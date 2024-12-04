import 'package:d2_touch/modules/data/tracker/entities/enrollment.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/queries/tracked_entity_attribute_value.query.dart';
import 'package:d2_touch/modules/data/tracker/queries/tracked_entity_instance.query.dart';
import 'package:d2_touch/modules/engine/program_rule/models/tracker_rule_result.model.dart';
import 'package:d2_touch/modules/engine/program_rule/utilities/program_rule_engine.util.dart';
import 'package:d2_touch/modules/engine/shared/utilities/data_value_entities.util.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule_action.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule_variable.entity.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_rule.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_rule_variable.query.dart';
import 'package:queue/queue.dart';
import 'package:sqflite/sqlite_api.dart';

class TrackerRuleEngine {
  late Database database;
  TrackerRuleEngine({required this.database});
  Future<TrackerRuleResult> execute(
      {required TrackedEntityInstance trackedEntityInstance,
      required String program,
      TrackedEntityAttributeValue? changedAttributeValue}) async {
    try {
      List<ProgramRule> programRules =
          await ProgramRuleQuery(database: database)
              .withActions()
              .where(attribute: 'program', value: program)
              .get();

      List<ProgramRuleVariable> programRuleVariables =
          await ProgramRuleVariableQuery(database: database)
              .where(attribute: 'program', value: program)
              .get();

      List<TrackedEntityAttributeValue> attributes =
          await TrackedEntityAttributeValueQuery(database: database)
              .where(
                  attribute: 'trackedEntityInstance',
                  value: trackedEntityInstance.trackedEntityInstance)
              .get();

      trackedEntityInstance =
          await TrackedEntityInstanceQuery(database: database)
                  .withEnrollments()
                  .byId(trackedEntityInstance.trackedEntityInstance ?? '')
                  .getOne() ??
              trackedEntityInstance;

      final dataValueEntities =
          DataValueEntities.fromAttributeValues(attributes);

      List<Enrollment> enrollments = (trackedEntityInstance.enrollments ?? []);

      List<ProgramRuleAction> programRuleActions = ProgramRuleEngine.execute(
          dataValueEntities: dataValueEntities,
          programRules: programRules,
          additionalValues: {
            'incident_date':
                enrollments.isNotEmpty ? enrollments[0].incidentDate : null,
            'enrollment_date':
                enrollments.isNotEmpty ? enrollments[0].enrollmentDate : null,
            'enrollment_id':
                enrollments.isNotEmpty ? enrollments[0].enrollment : null,
            'current_date': DateTime.now().toIso8601String(),
            'event_date': enrollments.isNotEmpty
                ? (enrollments[0].events ?? []).isNotEmpty
                    ? enrollments[0].events![0].eventDate
                    : DateTime.now().toIso8601String()
                : DateTime.now().toIso8601String(),
          },
          programRuleVariables: programRuleVariables);

      final queue = Queue(parallel: 50);
      num availableItemCount = 0;

      programRuleActions.forEach((programRuleAction) {
        if (programRuleAction.programRuleActionType == 'ASSIGN' &&
            programRuleAction.trackedEntityAttribute != null &&
            programRuleAction.data != null) {
          availableItemCount++;
          queue.add(() => TrackedEntityAttributeValueQuery(database: database)
              .setData(TrackedEntityAttributeValue(
                  synced: false,
                  lastUpdated: DateTime.now().toIso8601String(),
                  id:
                      "${trackedEntityInstance.trackedEntityInstance}_${programRuleAction.trackedEntityAttribute}",
                  dirty: true,
                  attribute: programRuleAction.trackedEntityAttribute as String,
                  trackedEntityInstance:
                      trackedEntityInstance.trackedEntityInstance,
                  value: programRuleAction.data as String))
              .save());
        }
      });

      if (availableItemCount == 0) {
        queue.cancel();
      } else {
        await queue.onComplete;
      }

      TrackedEntityInstance? updatedTrackedEntityInstance =
          await TrackedEntityInstanceQuery(database: database)
              .withAttributes()
              .withEnrollments()
              .byId(trackedEntityInstance.id as String)
              .getOne();

      return TrackerRuleResult(
          programRuleActions: programRuleActions,
          trackedEntityInstance:
              updatedTrackedEntityInstance ?? trackedEntityInstance);
    } catch (e) {
      return TrackerRuleResult(
          programRuleActions: [], trackedEntityInstance: trackedEntityInstance);
    }
  }

  List<ProgramRuleAction> forEvent(
      {TrackedEntityAttributeValue? attributeValue}) {
    return [];
  }
}
