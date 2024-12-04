import 'package:sqflite/sqflite.dart';

import '../../../../shared/queries/base.query.dart';
import '../entities/tracked_entity_instance_relationship.entity.dart';

class TrackedEntityInstanceRelationshipQuery extends BaseQuery<TrackedEntityInstanceRelationship> {
  TrackedEntityInstanceRelationshipQuery({Database? database}) : super(database: database);
}
