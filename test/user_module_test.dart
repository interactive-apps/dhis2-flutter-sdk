import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'user_module_test.reflectable.dart';

import 'package:d2_touch/d2_touch.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/src/adapters/dio_adapter.dart';
import '../sample/user_groups.sample.dart';
import '../sample/users.sample.dart';
import '../sample/current_user.sample.dart';
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

  dioAdapter.onGet(
      'https://play.dhis2.org/2.35.11/api/userGroups.json?fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,userGroupUsers[id,dirty,lastUpdated,created,userId,groupId]&paging=false',
      (server) => server.reply(200, sampleUserGroups));

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await d2.userModule.user.setData(user).save();

  await d2.userModule.userGroup.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  final userGroup = await d2.userModule.userGroup.get();

  test('should return a list of user groups', () {
    expect(userGroup.length, 31);
  });

  dioAdapter.onGet(
      'https://play.dhis2.org/2.35.11/api/users.json?fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,username,password,firstName,surname,phoneNumber,token,tokenType,refreshToken,tokenExpiry,authType,baseUrl,teiSearchOrganisationUnits,organisationUnits[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,orgUnit,type,user],authorities[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,authority,user],roles[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,user],dataViewOrganisationUnits,programs,dataSets,isLoggedIn,gender,jobTitle,userGroups[id,dirty,lastUpdated,created,userId,groupId]&userOrgUnits=false&includeChildren=false&paging=false',
      (server) => server.reply(200, usersSample));

  await d2.userModule.user.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  final userGroupUser = await d2.userModule.userGroupUser.get();
  test('should return 60 as number of userGroupUsers', () {
    expect(userGroupUser.length, 60);
  });

  dioAdapter.onGet(
      'https://play.dhis2.org/2.35.11/api/users.json?filter=userGroups.id:in:[Kk12LkEWtXp]&fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,username,password,firstName,surname,phoneNumber,token,tokenType,refreshToken,tokenExpiry,authType,baseUrl,teiSearchOrganisationUnits,organisationUnits[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,orgUnit,type,user],authorities[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,authority,user],roles[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,user],dataViewOrganisationUnits,programs,dataSets,isLoggedIn,gender,jobTitle,userGroups[id,dirty,lastUpdated,created,userId,groupId]&userOrgUnits=false&includeChildren=false&paging=false',
      (server) => server.reply(200, usersSample));

  await d2.userModule.user.byGroups(
      userGroupsId: ["Kk12LkEWtXp"],
      filterMode: 'id').download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  final userGroupUsers = await d2.userModule.userGroupUser.get();
  test('should return all users with the given group id', () {
    expect(userGroupUsers.length, 60);
  });

  dioAdapter.onGet(
      'https://play.dhis2.org/2.35.11/api/users.json?filter=userGroups.code:in:[78ghtZ]&fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,username,password,firstName,surname,phoneNumber,token,tokenType,refreshToken,tokenExpiry,authType,baseUrl,teiSearchOrganisationUnits,organisationUnits[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,orgUnit,type,user],authorities[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,authority,user],roles[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,user],dataViewOrganisationUnits,programs,dataSets,isLoggedIn,gender,jobTitle,userGroups[id,dirty,lastUpdated,created,userId,groupId]&userOrgUnits=false&includeChildren=false&paging=false',
      (server) => server.reply(200, usersSample));

  await d2.userModule.user.byGroups(
      userGroupsId: ["78ghtZ"],
      filterMode: 'code').download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  final usersByGroupCode = await d2.userModule.userGroupUser.get();
  test('should return all uses with the given group code', () {
    expect(usersByGroupCode.length, 60);
  });

  dioAdapter.onGet(
      'https://play.dhis2.org/2.35.11/api/users.json?filter=userGroups.code:in:[78ghtZ]&fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,username,password,firstName,surname,phoneNumber,token,tokenType,refreshToken,tokenExpiry,authType,baseUrl,teiSearchOrganisationUnits,organisationUnits[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,orgUnit,type,user],authorities[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,authority,user],roles[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,user],dataViewOrganisationUnits,programs,dataSets,isLoggedIn,gender,jobTitle,userGroups[id,dirty,lastUpdated,created,userId,groupId]&userOrgUnits=true&includeChildren=true&paging=false',
      (server) => server.reply(200, usersSample));

  await d2.userModule.user
      .byGroups(userGroupsId: ["78ghtZ"], filterMode: 'code')
      .byUserOrgUnits()
      .download((progress, complete) {
        print(progress.message);
      }, dioTestClient: dio);

  final usersByOrgUnit = await d2.userModule.userGroupUser.get();
  test(
      'should return all uses with the given group code and under the given org Unit',
      () {
    expect(usersByOrgUnit.length, 60);
  });
}
