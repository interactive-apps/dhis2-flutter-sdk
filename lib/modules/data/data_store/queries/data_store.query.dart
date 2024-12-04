import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:d2_touch/shared/queries/base.query.dart';

import '../../../../shared/models/request_progress.model.dart';
import '../../../../shared/utilities/http_client.util.dart';
import '../entities/data_store.entity.dart';

class DataStoreQuery extends BaseQuery<DataStore> {
  String? namespace;
  String? key;
  DataStoreQuery({Database? database, this.key, this.namespace})
      : super(database: database);

  byKey(String key) {
    this.key = key;
    return this;
  }

  byNamespace(String namespace) {
    this.namespace = namespace;
    return this;
  }

  @override
  Future<String> dhisUrl({List<String>? fields}) {
    return Future.value('dataStore/$namespace/$key');
  }

  @override
  Future<List<DataStore>?> download(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    if (this.namespace == null || this.key == null) {
      throw HttpException(
          'Provide namespace and key while downloading datastore');
    } else {
      callback(
          RequestProgress(
              resourceName: this.apiResourceName as String,
              message:
                  'Downloading ${this.apiResourceName?.toLowerCase()} from the server....',
              status: '',
              percentage: 0),
          false);

      this.data = await this.fetchOnline(dioTestClient: dioTestClient);

      callback(
          RequestProgress(
              resourceName: this.apiResourceName as String,
              message:
                  '${data.length} ${this.apiResourceName?.toLowerCase()} downloaded successfully',
              status: '',
              percentage: 50),
          false);

      if ((data ?? []).isNotEmpty) {
        callback(
            RequestProgress(
                resourceName: this.apiResourceName as String,
                message:
                    'Saving ${data.length} ${this.apiResourceName?.toLowerCase()} into phone database...',
                status: '',
                percentage: 51),
            false);

        await this.save();

        callback(
            RequestProgress(
                resourceName: this.apiResourceName as String,
                message:
                    '${data.length} ${this.apiResourceName?.toLowerCase()} successfully saved into the database',
                status: '',
                percentage: 100),
            true);

        return this.data;
      }

      callback(
          RequestProgress(
              resourceName: this.apiResourceName as String,
              message: 'No ${this.apiResourceName?.toLowerCase()} found',
              status: '',
              percentage: 100),
          true);

      return this.data;
    }
  }

  @override
  Future<List<DataStore>> fetchOnline({Dio? dioTestClient}) async {
    final dhisUrl = await this.dhisUrl();
    final response = await HttpClient.get(dhisUrl,
        database: this.database, dioTestClient: dioTestClient);

    final data = jsonEncode(response.body);

    var dataStore = DataStore(
        namespace: this.namespace!, key: this.key!, value: data, dirty: false);

    return [dataStore];
  }
}
