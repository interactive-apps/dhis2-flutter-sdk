import 'package:d2_touch/modules/auth/entities/user_organisation_unit.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class UserOrganisationUnitQuery extends BaseQuery<UserOrganisationUnit> {
  UserOrganisationUnitQuery({Database? database}) : super(database: database);
}
