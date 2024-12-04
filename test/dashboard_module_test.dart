import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/metadata/dashboard/entities/dashboard.entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'organisation_unit_module_test.reflectable.dart';
import '../sample/database_sample.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  var sharedPreferenceInstance = await SharedPreferences.getInstance();

  final d2 = await D2Touch.init(
    databaseFactory: databaseFactoryFfi,
    databaseName: randomStrings(),
    sharedPreferenceInstance: sharedPreferenceInstance,
  );

  final dashboard = Dashboard(
      id: 'test1',
      name: "Dashboard 1",
      displayName: 'Dashboard',
      itemCount: 5,
      dirty: false);

  var insertResult =
      await d2.dashboardModule.dashboard.setData(dashboard).save();

  test('should return success if data is inserted into the database', () {
    expect(insertResult, 1);
  });

  var result = await d2.dashboardModule.dashboard.byId('test1').getOne();

  test('should return saved details', () {
    expect(result.id, 'test1');
    expect(result.name, 'Dashboard 1');
  });

  await d2.dispose();
}
