import 'package:d2_touch/modules/metadata/option_set/queries/option_set.query.dart';
import 'package:sqflite/sqflite.dart';

class OptionSetModule {
  Database? database;
  OptionSetModule({this.database, String? locale});
  static createTables({required Database database}) async {
    await OptionSetQuery(database: database).createTable();
  }

  OptionSetQuery get optionSetQuery => OptionSetQuery(database: database);
}
