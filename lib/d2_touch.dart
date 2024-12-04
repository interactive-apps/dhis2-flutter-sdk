library d2_touch;

import 'package:d2_touch/core/database/database.util.dart';
import 'package:d2_touch/core/models/d2_touch.model.dart';
import 'package:d2_touch/modules/auth/auth.module.dart';
import 'package:d2_touch/modules/auth/user.module.dart';
import 'package:d2_touch/modules/data/aggregate/aggregate.module.dart';
import 'package:d2_touch/modules/data/data_store/data_store_entity.module.dart';
import 'package:d2_touch/modules/data/tracker/tracked_entity_instance.module.dart';
import 'package:d2_touch/modules/engine/engine.module.dart';
import 'package:d2_touch/modules/engine/http/http.module.dart';
import 'package:d2_touch/modules/file_resource/file_resource.module.dart';
import 'package:d2_touch/modules/metadata/dataset/data_set.module.dart';
import 'package:d2_touch/modules/metadata/option_group/option_group.module.dart';
import 'package:d2_touch/modules/metadata/option_set/option_set.module.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/organisation_unit.module.dart';
import 'package:d2_touch/modules/metadata/program/program.module.dart';
import 'package:d2_touch/modules/notification/notification.module.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'core/database/database_manager.dart';
import 'modules/auth/entities/user.entity.dart';
import 'modules/auth/models/auth-token.model.dart';
import 'modules/auth/models/login-response.model.dart';
import 'modules/auth/queries/user.query.dart';
import 'modules/auth/queries/user_organisation_unit.query.dart';
import 'modules/metadata/dashboard/dashboard.module.dart';
import 'modules/metadata/data_element/data_element.module.dart';

class D2Touch implements D2TouchModel {
  int? instanceVersion;
  String locale = 'en';
  Database? _database;
  bool? inMemory;
  DatabaseFactory? databaseFactory;
  late SharedPreferences sharedPreferenceInstance;
  DatabaseManager? databaseInstance;
  static D2Touch? _d2Instance;

  D2Touch._internal();

  UserModule get userModule => UserModule(database: _database, locale: locale);

  DataElementModule get dataElementModule =>
      DataElementModule(database: _database);

  ProgramModule get programModule => ProgramModule(database: _database);
  OptionGroupModule get optionGroupModule =>
      OptionGroupModule(database: _database);

  DataSetModule get dataSetModule => DataSetModule(database: _database);

  TrackedEntityInstanceModule get trackerModule => TrackedEntityInstanceModule(
      database: _database, instanceVersion: instanceVersion);

  OrganisationUnitModule get organisationUnitModule =>
      OrganisationUnitModule(database: _database);

  FileResourceModule get fileResourceModule =>
      FileResourceModule(database: _database);

  AggregateModule get aggregateModule => AggregateModule(database: _database);

  NotificationModule get notificationModule =>
      NotificationModule(database: _database);

  DashboardModule get dashboardModule => DashboardModule(database: _database);

  AuthModule get authModule => AuthModule(d2Instance: _d2Instance as D2Touch);

  HttpClientModule get httpClient => HttpClientModule(database: _database);

  EngineModule get engine => EngineModule(database: _database as Database);

  DataStoreModule get dataStore =>
      DataStoreModule(database: _database as Database);

  static Future<D2Touch> init({
    int? instanceVersion,
    String? locale,
    String? databaseName,
    bool? inMemory,
    DatabaseFactory? databaseFactory,
    SharedPreferences? sharedPreferenceInstance,
  }) async {
    if (_d2Instance == null) {
      _d2Instance = D2Touch._internal();

      if (locale != null) {
        _d2Instance?.locale = locale;
      }

      if (instanceVersion != null) {
        _d2Instance?.instanceVersion = instanceVersion;
      }

      _d2Instance?.inMemory = inMemory;
      _d2Instance?.databaseFactory = databaseFactory;
      _d2Instance?.sharedPreferenceInstance =
          sharedPreferenceInstance ?? await SharedPreferences.getInstance();

      final newDatabaseName =
          databaseName ?? await DatabaseUtil.getDatabaseName();

      if (newDatabaseName != null) {
        await _d2Instance?.setDatabase(
            databaseName: newDatabaseName,
            inMemory: inMemory,
            databaseFactory: databaseFactory,
            sharedPreferenceInstance:
                _d2Instance?.sharedPreferenceInstance as SharedPreferences);
      }
    }

    return _d2Instance as D2Touch;
  }

  Future<void> dispose() async {
    // locale = 'en';
    _database = null;
    // inMemory = null;
    // databaseFactory = null;
    await databaseInstance!.dispose();
    _d2Instance = null;
    await sharedPreferenceInstance.clear();
  }

  Future<DatabaseManager> setDatabase({
    required String databaseName,
    bool? inMemory,
    DatabaseFactory? databaseFactory,
    required SharedPreferences sharedPreferenceInstance,
  }) async {
    await DatabaseUtil.setDatabaseName(
        databaseName: databaseName,
        sharedPreferenceInstance: sharedPreferenceInstance);

    DatabaseManager(
        databaseName: databaseName,
        inMemory: inMemory,
        databaseFactory: databaseFactory);

    final databaseInstance = DatabaseManager.instance;

    final database = await databaseInstance!.database;

    await UserModule.createTables(database: database);
    await OrganisationUnitModule.createTables(database: database);
    await DataElementModule.createTables(database: database);
    await DataSetModule.createTables(database: database);
    await ProgramModule.createTables(database: database);
    await OptionGroupModule.createTables(database: database);
    await DashboardModule.createTables(database: database);
    await TrackedEntityInstanceModule.createTables(database: database);
    await AggregateModule.createTables(database: database);
    await OptionSetModule.createTables(database: database);
    await NotificationModule.createTables(database: database);
    await FileResourceModule.createTables(database: database);
    await DataStoreModule.createTables(database: database);

    _d2Instance?.databaseInstance = databaseInstance;
    _d2Instance!._database = database;

    return databaseInstance;
  }

  @deprecated
  static Future<Database?> initialize(
      {String? databaseName,
      bool? inMemory,
      DatabaseFactory? databaseFactory}) async {
    final newDatabaseName =
        databaseName ?? await DatabaseUtil.getDatabaseName();
    if (newDatabaseName != null) {
      DatabaseManager(
          databaseName: newDatabaseName,
          inMemory: inMemory,
          databaseFactory: databaseFactory);

      final database = await DatabaseManager.instance!.database;
      await UserModule.createTables(database: database);
      await OrganisationUnitModule.createTables(database: database);
      await DataElementModule.createTables(database: database);
      await DataSetModule.createTables(database: database);
      await ProgramModule.createTables(database: database);
      await OptionGroupModule.createTables(database: database);
      await DashboardModule.createTables(database: database);
      await TrackedEntityInstanceModule.createTables(database: database);
      await AggregateModule.createTables(database: database);
      await OptionSetModule.createTables(database: database);
      await NotificationModule.createTables(database: database);
      await FileResourceModule.createTables(database: database);

      return database;
    }

    return null;
  }

  @deprecated
  static Future<bool> isAuthenticated(
      {Future<SharedPreferences>? sharedPreferenceInstance,
      bool? inMemory,
      DatabaseFactory? databaseFactory}) async {
    WidgetsFlutterBinding.ensureInitialized();
    final databaseName = await DatabaseUtil.getDatabaseName(
        sharedPreferenceInstance: sharedPreferenceInstance);

    if (databaseName == null) {
      return false;
    }

    Database? database = await D2Touch.initialize(
        databaseName: databaseName,
        inMemory: inMemory,
        databaseFactory: databaseFactory);

    User? user = await UserQuery(database: database).getOne();

    return user?.isLoggedIn ?? false;
  }

  @deprecated
  static Future<LoginResponseStatus> logIn(
      {required String username,
      required String password,
      required String url,
      Future<SharedPreferences>? sharedPreferenceInstance,
      bool? inMemory,
      DatabaseFactory? databaseFactory,
      Dio? dioTestClient}) async {
    WidgetsFlutterBinding.ensureInitialized();
    HttpResponse userResponse = await HttpClient.get(
        'me.json?fields=id,name,created,lastUpdated,birthday,gender,displayName,jobTitle,surname,employer,email,firstName,phoneNumber,nationality,userCredentials[code,id,name,lastLogin,displayName,username,userRoles[id,name,code]],organisationUnits[id,code,name],dataViewOrganisationUnits[id,code,name],userGroups[id,name],authorities,programs,dataSets',
        baseUrl: url,
        username: username,
        password: password,
        dioTestClient: dioTestClient);

    if (userResponse.statusCode == 401) {
      return LoginResponseStatus.WRONG_CREDENTIALS;
    }

    if (userResponse.statusCode == 500) {
      return LoginResponseStatus.SERVER_ERROR;
    }

    final uri = Uri.parse(url).host;
    final String databaseName = '${username}_$uri';

    await D2Touch.initialize(
        databaseName: databaseName,
        inMemory: inMemory,
        databaseFactory: databaseFactory);

    final preferenceInstance =
        await sharedPreferenceInstance ?? await SharedPreferences.getInstance();

    await DatabaseUtil.setDatabaseName(
        databaseName: databaseName,
        sharedPreferenceInstance: preferenceInstance);

    final database = await DatabaseManager.instance!.database;

    UserQuery userQuery = UserQuery(database: database);

    Map<String, dynamic> userData = userResponse.body;
    userData['password'] = password;
    userData['isLoggedIn'] = true;
    userData['username'] = username;
    userData['baseUrl'] = url;
    userData['authTye'] = 'basic';
    userData['dirty'] = true;

    final user = User.fromApi(userData);
    await userQuery.setData(user).save();

    await UserOrganisationUnitQuery(database: database)
        .setData(user.organisationUnits)
        .save();

    return LoginResponseStatus.ONLINE_LOGIN_SUCCESS;
  }

  @deprecated
  static Future<bool> logOut() async {
    WidgetsFlutterBinding.ensureInitialized();
    bool logOutSuccess = false;

    try {
      Database database = await DatabaseManager.instance!.database;
      User? currentUser = await UserQuery(database: database).getOne();

      currentUser?.isLoggedIn = false;
      currentUser?.dirty = true;

      await UserQuery(database: database).setData(currentUser).save();

      logOutSuccess = true;
    } catch (e) {}
    return logOutSuccess;
  }

  @deprecated
  static Future<LoginResponseStatus> setToken(
      {required String instanceUrl,
      required Map<String, dynamic> userObject,
      required Map<String, dynamic> tokenObject,
      Future<SharedPreferences>? sharedPreferenceInstance,
      bool? inMemory,
      DatabaseFactory? databaseFactory,
      Dio? dioTestClient}) async {
    final uri = Uri.parse(instanceUrl).host;
    final String databaseName = '$uri';
    await D2Touch.initialize(
        databaseName: databaseName,
        inMemory: inMemory,
        databaseFactory: databaseFactory);

    final preferenceInstance =
        await sharedPreferenceInstance ?? await SharedPreferences.getInstance();
    await DatabaseUtil.setDatabaseName(
        databaseName: databaseName,
        sharedPreferenceInstance: preferenceInstance);

    AuthToken token = AuthToken.fromJson(tokenObject);

    List<dynamic> authorities = [];

    userObject['userCredentials']['userRoles'].forEach((role) {
      List<dynamic> authoritiesToAdd = role["authorities"].map((auth) {
        return auth as String;
      }).toList();

      authorities.addAll(authoritiesToAdd);
    });

    userObject['token'] = token.accessToken;
    userObject['tokenType'] = token.tokenType;
    userObject['tokenExpiry'] = token.expiresIn;
    userObject['refreshToken'] = token.refreshToken;
    userObject['isLoggedIn'] = true;
    userObject['dirty'] = true;
    userObject['baseUrl'] = instanceUrl;
    userObject['authType'] = "token";
    userObject['authorities'] = authorities;

    final database = await DatabaseManager.instance!.database;

    final user = User.fromApi(userObject);
    await UserQuery(database: database).setData(user).save();

    await UserOrganisationUnitQuery(database: database)
        .setData(user.organisationUnits)
        .save();

    return LoginResponseStatus.ONLINE_LOGIN_SUCCESS;
  }

  @Deprecated('Use [EngineModule] instead.')
  static Future<List<Map>> rawQuery(
      {required String query, required List args}) async {
    final Database db = await DatabaseManager.instance!.database;

    final List<Map> queryResult = await db.rawQuery(query.toString(), args);

    return queryResult;
  }
}
