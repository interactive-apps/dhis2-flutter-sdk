import 'package:d2_touch/modules/file_resource/queries/file_resource.query.dart';
import 'package:sqflite/sqflite.dart';

class FileResourceModule {
  Database? database;
  FileResourceModule({this.database, String? locale});
  static createTables({required Database database}) async {
    await FileResourceQuery(database: database).createTable();
  }

  FileResourceQuery get fileResource => FileResourceQuery(database: database);
}
