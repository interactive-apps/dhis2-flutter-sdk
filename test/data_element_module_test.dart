import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/metadata/data_element/entities/data_element.entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/data_elements.sample.dart';
import 'data_element_module_test.reflectable.dart';
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

  final dataElement = DataElement(
      id: 'test1',
      name: "Test 1",
      shortName: 'Test 1',
      valueType: 'TEXT',
      aggregationType: 'SUM',
      dirty: false);

  var insertResult =
      await d2.dataElementModule.dataElement.setData(dataElement).save();

  test('should return success if data is inserted into the database', () {
    expect(insertResult, 1);
  });

  var result = await d2.dataElementModule.dataElement.byId('test1').getOne();

  test('should return saved details', () {
    expect(result.id, 'test1');
    expect(result.name, 'Test 1');
    expect(result.shortName, 'Test 1');
    expect(result.valueType, 'TEXT');
    expect(result.aggregationType, 'SUM');
  });

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await d2.userModule.user.setData(user).save();

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/dataElements.json?fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,formName,valueType,aggregationType,description&paging=false',
    (server) => server.reply(200, sampleDataElements),
  );

  await d2.dataElementModule.dataElement.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<DataElement> dataElements = await d2.dataElementModule.dataElement.get();

  test('should store all incoming data element metadata', () {
    expect(dataElements.length, 51);
  });

  await d2.dispose();
}
