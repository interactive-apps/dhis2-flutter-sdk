import 'package:d2_touch/modules/metadata/program/queries/attribute_option.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_relationship.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_rule.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_rule_action.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_rule_variable.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_section.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_section_attribute.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_stage.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_stage_data_element.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_stage_section.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_stage_section_data_element.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_tracked_entity_attribute.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/tracked_entity_attribute.query.dart';
import 'package:sqflite/sqflite.dart';

import 'queries/program_stage_data_element_option.query.dart';

class ProgramModule {
  Database? database;
  ProgramModule({this.database, String? locale});
  static createTables({required Database database}) async {
    await ProgramQuery(database: database).createTable();
    await ProgramStageQuery(database: database).createTable();
    await ProgramStageSectionQuery(database: database).createTable();
    await ProgramStageSectionDataElementQuery(database: database).createTable();
    await ProgramStageDataElementOptionQuery(database: database).createTable();
    await AttributeOptionQuery(database: database).createTable();
    await ProgramTrackedEntityAttributeQuery(database: database).createTable();
    await ProgramStageDataElementQuery(database: database).createTable();
    await ProgramRuleQuery(database: database).createTable();
    await ProgramRuleActionQuery(database: database).createTable();
    await ProgramRuleVariableQuery(database: database).createTable();
    await ProgramSectionQuery(database: database).createTable();
    await TrackedEntityAttributeQuery(database: database).createTable();
    await ProgramSectionAttributeQuery(database: database).createTable();
    await ProgramRelationshipQuery(database: database).createTable();
  }

  ProgramQuery get program => ProgramQuery(database: database);

  ProgramStageQuery get programStage => ProgramStageQuery(database: database);

  ProgramTrackedEntityAttributeQuery get programTrackedEntityAttribute =>
      ProgramTrackedEntityAttributeQuery(database: database);

  AttributeOptionQuery get attributeOption =>
      AttributeOptionQuery(database: database);

  ProgramStageSectionQuery get programStageSection =>
      ProgramStageSectionQuery(database: database);

  ProgramStageDataElementQuery get programStageDataElement =>
      ProgramStageDataElementQuery(database: database);

  ProgramStageDataElementOptionQuery get programStageDataElementOption =>
      ProgramStageDataElementOptionQuery(database: database);

  ProgramRuleQuery get programRule => ProgramRuleQuery(database: database);

  ProgramRuleActionQuery get programRuleAction =>
      ProgramRuleActionQuery(database: database);

  ProgramRuleVariableQuery get programRuleVariable =>
      ProgramRuleVariableQuery(database: database);

  ProgramSectionQuery get programSection =>
      ProgramSectionQuery(database: database);

  ProgramSectionAttributeQuery get programSectionAttribute =>
      ProgramSectionAttributeQuery(database: database);

  TrackedEntityAttributeQuery get trackedEntityAttribute =>
      TrackedEntityAttributeQuery(database: database);

  ProgramRelationshipQuery get programRelationship =>
      ProgramRelationshipQuery(database: database);
}
