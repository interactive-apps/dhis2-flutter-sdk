import 'package:d2_touch/modules/data/aggregate/queries/data_value.query.dart';
import 'package:d2_touch/modules/data/aggregate/queries/data_value_set.query.dart';
import 'package:sqflite/sqflite.dart';

class AggregateModule {
  Database? database;
  AggregateModule({this.database, String? locale});
  static createTables({required Database database}) async {
    await DataValueSetQuery(database: database).createTable();
    await DataValueQuery(database: database).createTable();
  }

  DataValueQuery get dataValue => DataValueQuery(database: database);

  DataValueSetQuery get dataValueSet => DataValueSetQuery(database: database);
}
