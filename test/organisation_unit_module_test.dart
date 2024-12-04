import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/org_unit.sample.dart';
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

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await d2.userModule.user.setData(user).save();
  await d2.userModule.userOrganisationUnit
      .setData(user.organisationUnits)
      .save();

  final organisationUnit = OrganisationUnit(
      id: 'ImspTQPwCqd',
      name: "Test 1",
      level: 1,
      path: 'test1',
      shortName: 'Test 1',
      openingDate: '20-01-2020',
      parent: "{id: qtr8GGlm4gg}",
      dirty: false);

  var insertResult = await d2.organisationUnitModule.organisationUnit
      .setData(organisationUnit)
      .save();

  test('should return success if data is inserted into the database', () {
    expect(insertResult, 1);
  });

  var result = await d2.organisationUnitModule.organisationUnit
      .byId('ImspTQPwCqd')
      .getOne();

  test('should return saved details', () {
    expect(result!.id, 'ImspTQPwCqd');
    expect(result!.name, 'Test 1');
    expect(result!.parent, '{id: qtr8GGlm4gg}');
  });

  List<OrganisationUnit>? userOrgUnits =
      await d2.organisationUnitModule.organisationUnit.getUserOrgUnits();

  test('should return user organisation units', () {
    expect(userOrgUnits?[0].id, 'ImspTQPwCqd');
    expect(userOrgUnits?[0].name, 'Test 1');
  });

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/organisationUnits.json?filter=path:ilike:ImspTQPwCqd&rootJunction=OR&fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,level,path,externalAccess,openingDate,geometry,parent&paging=false',
    (server) => server.reply(200, sampleOrganisationUnits),
  );

  await d2.organisationUnitModule.organisationUnit.download(
      (progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<OrganisationUnit> orgUnits =
      await d2.organisationUnitModule.organisationUnit.get();

  test('should store all incoming organisation unit metadata', () {
    expect(orgUnits.length, 51);
  });

  OrganisationUnit? childOrgUnit = await d2
      .organisationUnitModule.organisationUnit
      .where(attribute: 'parent', value: 'qtr8GGlm4gg')
      .getOne();

  test('should return result given parent id is passed where clause', () {
    expect(childOrgUnit?.parent, 'qtr8GGlm4gg');
  });

  await d2.dispose();
}
