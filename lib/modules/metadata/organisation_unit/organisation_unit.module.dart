import 'package:d2_touch/modules/metadata/organisation_unit/queries/organisation_unit.query.dart';
import 'package:sqflite/sqflite.dart';

class OrganisationUnitModule {
  Database? database;
  OrganisationUnitModule({this.database, String? locale});
  static createTables({required Database database}) async {
    return await OrganisationUnitQuery(database: database).createTable();
  }

  OrganisationUnitQuery get organisationUnit =>
      OrganisationUnitQuery(database: database);
}
