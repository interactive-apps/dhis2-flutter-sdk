import 'package:d2_touch/modules/data/data_store/queries/data_store.query.dart';
import 'package:sqflite/sqflite.dart';


class DataStoreModule {
  Database? database;

  DataStoreModule({this.database, String? locale});
  static createTables({required Database database}) async {
    await DataStoreQuery(database: database).createTable();
  }

  DataStoreQuery get dataStoreQuery => DataStoreQuery(database: database);
}