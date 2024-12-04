import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/models/login-response.model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/auth-token.sample.dart';
import '../sample/current_user.sample.dart';
import 'auth_test.reflectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  var sharedPreferenceInstance = await SharedPreferences.getInstance();

  final d2 = await D2Touch.init(
      sharedPreferenceInstance: sharedPreferenceInstance,
      databaseFactory: databaseFactoryFfi,
      inMemory: true);

  final isAuthenticated = await d2.authModule.isAuthenticated();

  test('should not be authenticated if database is not set', () {
    expect(isAuthenticated, false);
  });

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/me.json?fields=id,name,created,lastUpdated,birthday,gender,displayName,jobTitle,surname,employer,email,firstName,phoneNumber,nationality,userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]],organisationUnits[id,code,name],dataViewOrganisationUnits[id,code,name],userGroups[id,name],authorities,programs,dataSets',
    (server) => server.reply(200, userData),
  );

  final onlineLogIn = await d2.authModule.logIn(
      username: 'admin',
      password: 'district',
      url: 'https://play.dhis2.org/2.35.11',
      dioTestClient: dio);

  final user = await d2.userModule.user.withAuthorities().withRoles().getOne();

  test('should successfully authenticate user on online login', () {
    expect(onlineLogIn, LoginResponseStatus.ONLINE_LOGIN_SUCCESS);
  });

  test('should return appropriate user roles for a user', () {
    expect(user?.roles?.length, 13);
  });

  final logOutResponse = await d2.authModule.logOut();

  final isAuthenticatedAfterLogout = await d2.authModule.isAuthenticated();

  test('should successfully log out user', () {
    expect(logOutResponse, true);
    expect(isAuthenticatedAfterLogout, false);
  });

  await d2.dispose();

  final d2TokenBased = await D2Touch.init(
      sharedPreferenceInstance: sharedPreferenceInstance,
      databaseFactory: databaseFactoryFfi);

  await d2TokenBased.authModule.setToken(
      instanceUrl: 'https://dev.dhis2.udsm.ac.tz',
      userObject: userData,
      tokenObject: wrongSampleAuthToken);

  User? userWithToken = await d2TokenBased.userModule.user.getOne();

  test('should get user information with authentication token', () async {
    expect(userWithToken, isNotNull);
    expect(userWithToken?.token, '6NK1ZJIWakbVaftAQnigzWgue98');
    expect(userWithToken?.tokenType, 'bearer');
  });

  dioAdapter.onGet(
    'https://dev.dhis2.udsm.ac.tz/api/me.json?fields=id,name,created,lastUpdated,birthday,gender,displayName,jobTitle,surname,employer,email,firstName,nationality,userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]],organisationUnits[id,code,name],dataViewOrganisationUnits[id,code,name],userGroups[id,name],authorities,programs,dataSets',
    (server) => server.reply(401,
        '<InvalidTokenException><error>invalid_token</error><error_description>Invalid access token: 6NK1ZJIWakbVaftAQnigzWgue98</error_description></InvalidTokenException>'),
  );

  final invalidTokenResponse = await d2TokenBased.httpClient.get(
      'me.json?fields=id,name,created,lastUpdated,birthday,gender,displayName,jobTitle,surname,employer,email,firstName,nationality,userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]],organisationUnits[id,code,name],dataViewOrganisationUnits[id,code,name],userGroups[id,name],authorities,programs,dataSets',
      dioTestClient: dio);

  test("should return error message and status for invalid token", () {
    expect(invalidTokenResponse.statusCode, 401);
    expect(invalidTokenResponse.body['InvalidTokenException']['error'],
        'invalid_token');
  });

  // Setting correct token
  await d2TokenBased.authModule.setToken(
      instanceUrl: 'https://dev.dhis2.udsm.ac.tz',
      userObject: userData,
      tokenObject: correctSampleAuthToken);

  User? userWithCorrectToken = await d2TokenBased.userModule.user.getOne();

  test('should get user information with correct authentication token',
      () async {
    expect(userWithCorrectToken, isNotNull);
    expect(userWithCorrectToken?.token, '6NK1ZJIWakbVaftAQ78gzWgue98');
    expect(userWithCorrectToken?.tokenType, 'bearer');
  });

  dioAdapter.onGet(
    'https://dev.dhis2.udsm.ac.tz/api/me.json?fields=id,name,created,lastUpdated,birthday,gender,displayName,jobTitle,surname,employer,email,firstName,nationality,userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]],organisationUnits[id,code,name],dataViewOrganisationUnits[id,code,name],userGroups[id,name],authorities,programs,dataSets',
    (server) => server.reply(200, userData),
  );

  final validTokenResponse = await d2TokenBased.httpClient.get(
      'me.json?fields=id,name,created,lastUpdated,birthday,gender,displayName,jobTitle,surname,employer,email,firstName,nationality,userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]],organisationUnits[id,code,name],dataViewOrganisationUnits[id,code,name],userGroups[id,name],authorities,programs,dataSets',
      dioTestClient: dio);

  test("should return given data from the server", () {
    expect(validTokenResponse.statusCode, 200);
    expect(validTokenResponse.body['id'], 'xE7jOejl9FI');
  });

  await d2.dispose();
}
