import 'package:d2_touch/modules/auth/queries/user.query.dart';
import 'package:d2_touch/modules/auth/queries/user_authority.query.dart';
import 'package:d2_touch/modules/auth/queries/user_group.query.dart';
import 'package:d2_touch/modules/auth/queries/user_group_users.query.dart';
import 'package:d2_touch/modules/auth/queries/user_organisation_unit.query.dart';
import 'package:d2_touch/modules/auth/queries/user_role.query.dart';
import 'package:sqflite/sqflite.dart';

class UserModule {
  Database? database;
  UserModule({this.database, String? locale});
  static createTables({required Database database}) async {
    await UserQuery(database: database).createTable();
    await UserOrganisationUnitQuery(database: database).createTable();
    await UserAuthorityQuery(database: database).createTable();
    await UserRoleQuery(database: database).createTable();
    await UserGroupQuery(database: database).createTable();
    await UserGroupUserQuery(database: database).createTable();
  }

  UserQuery get user => UserQuery(database: database);

  UserOrganisationUnitQuery get userOrganisationUnit =>
      UserOrganisationUnitQuery(database: database);

  UserAuthorityQuery get userAuthority =>
      UserAuthorityQuery(database: database);

  UserRoleQuery get userRole => UserRoleQuery(database: database);

  UserGroupQuery get userGroup => UserGroupQuery(database: database);
  UserGroupUserQuery get userGroupUser => UserGroupUserQuery(database: database);
}
