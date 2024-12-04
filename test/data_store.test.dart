import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'user_module_test.reflectable.dart';

import 'package:d2_touch/d2_touch.dart';
import '../sample/current_user.sample.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/src/adapters/dio_adapter.dart';
import '../sample/data_store.sample.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import '../lib/modules/auth/entities/user_group.entity.dart';
import '../sample/database_sample.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  var sharedPreferenceInstance = await SharedPreferences.getInstance();

  final d2 = await D2Touch.init(
    databaseFactory: databaseFactoryFfi,
    databaseName: randomStrings(),
    sharedPreferenceInstance: sharedPreferenceInstance,
  );

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await d2.userModule.user.setData(user).save();

  dioAdapter.onGet(
      'https://play.dhis2.org/2.35.11/api/dataStore/eidsr-configurations/settings',
      (server) => server.reply(200, dataStoreSample));

  await d2.dataStore.dataStoreQuery
      .byNamespace('eidsr-configurations')
      .byKey('settings')
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  final store = await d2.dataStore.dataStoreQuery.get();

  test('should return number of the data store', () {
    expect(store.length, 1);
  });
}
