import 'package:d2_touch/modules/metadata/dashboard/queries/dashboard.query.dart';
import 'package:d2_touch/modules/metadata/dashboard/queries/dashboard_item.query.dart';
import 'package:sqflite/sqflite.dart';

class DashboardModule {
  Database? database;
  DashboardModule({this.database, String? locale});
  static createTables({required Database database}) async {
    await DashboardQuery(database: database).createTable();
    await DashboardItemQuery(database: database).createTable();
  }

  DashboardQuery get dashboard => DashboardQuery(database: database);
  DashboardItemQuery get dashboardItem =>
      DashboardItemQuery(database: database);
}
