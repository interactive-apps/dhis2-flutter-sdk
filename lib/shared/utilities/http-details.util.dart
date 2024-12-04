import 'dart:convert';

import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/models/auth-token.model.dart';
import 'package:d2_touch/modules/auth/queries/user.query.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

class OAuthToken {
  String token;
  int expiresIn;
  DateTime tokenExpiresAt;
  String refreshToken;
  String url;

  OAuthToken(
      {required this.token,
      required this.expiresIn,
      required this.tokenExpiresAt,
      required this.url,
      required this.refreshToken});

  bool isTokenExpired() {
    return DateTime.now().isAfter(tokenExpiresAt);
  }

  Future<dynamic> renew() async {
    BaseOptions options = BaseOptions(
        baseUrl: url,
        validateStatus: (status) => status == 200,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60000),
        receiveTimeout: const Duration(seconds: 60000));

    try {
      final dio = Dio(options);

      final response = await dio.get(
        '/oauth/token/refresh?token=${this.refreshToken}&isNew=true',
      );
      return response.data;
    } on DioException catch (e) {
      return e.response?.data ?? {};
    }
  }
}

class HttpDetails {
  Database? database;
  String? baseUrl;
  String? username;
  String? password;
  String? token;
  String? tokenType;
  User? user;
  HttpDetails({
    this.username,
    this.password,
    this.baseUrl,
    this.token,
    this.tokenType,
    this.database,
  });

  Future<HttpDetails> get() async {
    if (this.username != null &&
        this.password != null &&
        this.baseUrl != null) {
      return this;
    }

    final User? user = await UserQuery(database: database).getOne();
    this.username = user?.username;
    this.password = user?.password;
    this.baseUrl = user?.baseUrl;
    this.token = user?.token;
    this.tokenType = user?.tokenType;

//!TODO: Improve token refresh implementation not to use the SDK core
//!TODO!: Improve token refresh implementation not to use the SDK core
    if (this.token != null &&
        (this.tokenType == 'bearer' || this.tokenType == 'ApiToken')) {
      final OAuthToken token = OAuthToken(
        token: this.token as String,
        expiresIn: user?.tokenExpiry as int,
        refreshToken: user?.refreshToken as String,
        url: user?.baseUrl as String,
        tokenExpiresAt: DateTime.parse(user?.tokenExpiresAt as String),
      );
      if (token.isTokenExpired() && user != null) {
        dynamic tokenObject = await token.renew();
        if (tokenObject != null && tokenObject['access_token'] != null) {
          dynamic userObject = user.toJson();
          AuthToken authToken = AuthToken.fromJson(tokenObject);
          userObject['token'] = authToken.accessToken;
          userObject['tokenType'] = authToken.tokenType;
          userObject['tokenExpiry'] = token.expiresIn;
          userObject['refreshToken'] = token.refreshToken;
          userObject['isLoggedIn'] = true;
          userObject['dirty'] = true;
          userObject['authType'] = "token";
          userObject['tokenExpiresAt'] = DateTime.now()
              .add(Duration(seconds: token.expiresIn))
              .toIso8601String();
          User userData = User.fromApi(userObject);
          await UserQuery(database: database).setData(userData).save();
          this.token = authToken.accessToken;
        }
      }
    }
    return Future.value(this);
  }

  String get authToken {
    if (this.token != null) {
      return this.token as String;
    }
    return base64Encode(utf8.encode('${this.username}:${this.password}'));
  }

  String get authTokenType {
    switch (this.tokenType) {
      case 'bearer':
        return 'Bearer';
      case 'ApiToken':
        return 'ApiToken';
      default:
        return 'Basic';
    }
  }
}
