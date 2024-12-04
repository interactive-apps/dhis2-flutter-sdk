import 'package:d2_touch/modules/data/tracker/queries/tracked_entity_instance_relationship.query.dart';
import 'package:sqflite/sqflite.dart';

import 'queries/attribute_reserved_value.query.dart';
import 'queries/enrollment.query.dart';
import 'queries/event.query.dart';
import 'queries/event_data_value.query.dart';
import 'queries/tracked_entity_attribute_value.query.dart';
import 'queries/tracked_entity_instance.query.dart';

class TrackedEntityInstanceModule {
  Database? database;
  int? instanceVersion;
  TrackedEntityInstanceModule(
      {this.database, String? locale, this.instanceVersion});

  static createTables({required Database database}) async {
    await TrackedEntityInstanceQuery(database: database).createTable();
    await TrackedEntityAttributeValueQuery(database: database).createTable();
    await EventQuery(database: database).createTable();
    await EnrollmentQuery(database: database).createTable();
    await AttributeReservedValueQuery(database: database).createTable();
    await EventDataValueQuery(database: database).createTable();
    await TrackedEntityInstanceRelationshipQuery(database: database)
        .createTable();
  }

  TrackedEntityInstanceQuery get trackedEntityInstance =>
      TrackedEntityInstanceQuery(database: database);

  TrackedEntityAttributeValueQuery get trackedEntityAttributeValue =>
      TrackedEntityAttributeValueQuery(database: database);

  EventQuery get event => EventQuery(database: database, instanceVersion: instanceVersion);

  EnrollmentQuery get enrollment => EnrollmentQuery(database: database);

  AttributeReservedValueQuery get attributeReservedValue =>
      AttributeReservedValueQuery(database: database);

  EventDataValueQuery get eventDataValue =>
      EventDataValueQuery(database: database);

  TrackedEntityInstanceRelationshipQuery
      get trackedEntityInstanceRelationship =>
          TrackedEntityInstanceRelationshipQuery(database: database);
}
