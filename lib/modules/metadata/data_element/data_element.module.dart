import 'package:d2_touch/modules/metadata/data_element/queries/data_element.query.dart';
import 'package:sqflite/sqflite.dart';

class DataElementModule {
  Database? database;
  DataElementModule({this.database, String? locale});
  static createTables({required Database database}) async {
    await DataElementQuery(database: database).createTable();
  }

  DataElementQuery get dataElement => DataElementQuery(database: database);
}
