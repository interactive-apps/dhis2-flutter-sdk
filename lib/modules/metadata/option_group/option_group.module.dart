import 'package:d2_touch/modules/metadata/option_group/queries/option_group.query.dart';
import 'package:sqflite/sqflite.dart';

class OptionGroupModule {
  Database? database;
  OptionGroupModule({this.database, String? locale});
  static createTables({required Database database}) async {
    await OptionGroupQuery(database: database).createTable();
  }

  OptionGroupQuery get optionGroup => OptionGroupQuery(database: database);
}
