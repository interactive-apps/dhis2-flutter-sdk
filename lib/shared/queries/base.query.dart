import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/shared/entities/base.entity.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/utilities/dhis-url-generator.util.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:d2_touch/shared/utilities/merge_mode.util.dart';
import 'package:d2_touch/shared/utilities/query_filter.util.dart';
import 'package:d2_touch/shared/utilities/query_filter_condition.util.dart';
import 'package:d2_touch/shared/utilities/query_model.util.dart';
import 'package:d2_touch/shared/utilities/save_option.util.dart';
import 'package:d2_touch/shared/utilities/sort_order.util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:reflectable/mirrors.dart';
import 'package:sqflite/sqflite.dart';

class BaseQuery<T extends BaseEntity> {
  Database? database;
  late Repository repository;
  dynamic data;
  List<String>? fields;

  /// A list of strings as an argument for the [select] method.
  /// It can contain various fields as accepted by the DHIS2 API.
  ///
  /// Example:
  /// ```dart
  /// List<String> fields = ['id', 'name', 'path'];
  /// select(fields);
  /// ```
  ///
  /// Ensure that [select] is not null before calling this method.
  ///
  List<String> selected;
  Column? primaryKey;
  String? tableName;
  String? apiResourceName;
  String? singularResourceName;
  String? id;
  String? junctionOperator;
  List<QueryFilter>? filters = [];
  Map<String, SortOrder> sortOrder = {};
  List<ColumnRelation> relations = [];
  MergeMode _mergeMode = MergeMode.Replace;

  BaseQuery({this.database, this.junctionOperator, this.selected = const []}) {
    this.repository = Repository<T>(database: database as Database);
    this.tableName = repository.entity.tableName;
    this.apiResourceName = repository.entity.apiResourceName;

    Iterable<Column> newColumns = repository.columns.where((column) =>
        column.relation == null ||
        column.relation?.relationType != RelationType.OneToMany);

    this.fields = newColumns.map((column) => column.name ?? '').toList();
    this.primaryKey = repository.columns.firstWhere((column) => column.primary);
  }

  set mergeMode(MergeMode mergeMode) {
    this._mergeMode = mergeMode;
  }

  /// A method that accepted a list of user selected fields as an argument .
  /// Fields as accepted by the DHIS2 API.
  ///
  /// Example:
  /// ```dart
  /// List<String> fields = ['id', 'name', 'path'];
  /// select(fields);
  /// ```
  select(List<String> fields) {
    this.fields = fields;
    this.selected = fields;
    return this;
  }

  byId(String id) {
    this.id = id;
    this.filters = [];
    return this.where(attribute: 'id', value: id);
  }

  byIds(List<String> ids) {
    this.id = null;
    return this.whereIn(attribute: 'id', values: ids, merge: false);
  }

  whereIn(
      {required String attribute,
      required List<String> values,
      required bool merge}) {
    if (merge) {
      this.filters?.add(QueryFilter(
          attribute: attribute, condition: QueryCondition.In, value: values));
    } else {
      this.filters = [
        QueryFilter(
            attribute: attribute, condition: QueryCondition.In, value: values)
      ];
    }

    return this;
  }

  where({required String attribute, @required dynamic value}) {
    this.filters?.add(QueryFilter(
        attribute: attribute, condition: QueryCondition.Equal, value: value));

    return this;
  }

  like({required String attribute, required dynamic value}) {
    this.filters?.add(QueryFilter(
        attribute: attribute, condition: QueryCondition.Like, value: value));
    return this;
  }

  ilike(
      {required String attribute,
      required dynamic value,
      String? filterCondition,
      String? key,
      String? keyValue}) {
    this.filters?.add(QueryFilter(
        attribute: attribute,
        condition: QueryCondition.Ilike,
        value: value,
        filterCondition: filterCondition,
        key: key,
        keyValue: keyValue));
    return this;
  }

  greaterThan({required String attribute, required dynamic value}) {
    this.filters?.add(QueryFilter(
        attribute: attribute,
        condition: QueryCondition.GreaterThan,
        value: value));
    return this;
  }

  greaterThanOrEqual({required String attribute, required dynamic value}) {
    this.filters?.add(QueryFilter(
        attribute: attribute,
        condition: QueryCondition.GreaterThanOrEqualTo,
        value: value));
    return this;
  }

  lessThan({required String attribute, @required dynamic value}) {
    this.filters?.add(QueryFilter(
        attribute: attribute,
        condition: QueryCondition.LessThan,
        value: value));
    return this;
  }

  lessThanOrEqual({required String attribute, required dynamic value}) {
    this.filters?.add(QueryFilter(
        attribute: attribute,
        condition: QueryCondition.LessThanOrEqualTo,
        value: value));
    return this;
  }

  orderBy({required String attribute, required SortOrder order}) {
    this.sortOrder[attribute] = order;
    return this;
  }

  setData(dynamic data) {
    this.data = data;
    return this;
  }

  QueryModel get query {
    List<QueryFilter>? filters = this.filters;
    if (this.id != null) {
      filters = [
        QueryFilter(
          attribute: 'id',
          condition: QueryCondition.Equal,
          value: this.id,
        )
      ];
    }

    return QueryModel(
        resourceName: this.apiResourceName as String,
        tableName: this.tableName as String,
        singularResourceName: this.singularResourceName,
        fields: this.fields as List<String>,
        filters: filters,
        relations: this.relations,
        columns: this.repository.columns,
        junctionOperator: this.junctionOperator);
  }

  Future<List<T>> get({Dio? dioTestClient, bool? online}) async {
    if (online == true) {
      return this.fetchOnline(dioTestClient: dioTestClient);
    }

    if (this.id != null) {
      return this.repository.find(
          id: this.id,
          fields: this.fields as List<String>,
          database: this.database,
          relations: this.relations) as Future<List<T>>;
    }

    return this.repository.findAll(
        database: this.database,
        filters: this.filters,
        fields: this.fields as List<String>,
        sortOrder: this.sortOrder,
        relations: this.relations) as Future<List<T>>;
  }

  Future<T?> getOne({Dio? dioTestClient, bool? online}) async {
    if (online == true) {
      return (await this.fetchOnline(dioTestClient: dioTestClient))[0];
    }

    List<T> results = await this.get();

    return results.length > 0 ? results[0] : null;
  }

  Future<int> save({SaveOptions? saveOptions}) async {
    if (this.data is List) {
      return this.repository.saveMany(
          entities: this.data as List<T>,
          database: this.database,
          mergeMode: this._mergeMode,
          saveOptions: saveOptions);
    }
    if (this.data != null && this.data.lastUpdated == null) {
      this.data.lastUpdated = DateTime.now().toIso8601String();
    }

    return this.repository.saveOne(
        entity: this.data as T,
        database: this.database,
        mergeMode: this._mergeMode,
        saveOptions: saveOptions);
  }

  Future delete() {
    if (this.id != null) {
      return this
          .repository
          .deleteById(id: this.id as String, database: this.database);
    }

    return this.repository.deleteAll();
  }

  Future createTable() async {
    return await this.repository.create(database: this.database);
  }

  Future count() {
    return this.repository.count(database: this.database);
  }

  Future create() {
    return this.repository.create(database: database);
  }

  Future<List<T>> fetchOnline({Dio? dioTestClient}) async {
    try {
      final dhisUrl = await this.dhisUrl();
      final response = await HttpClient.get(dhisUrl,
          database: this.database, dioTestClient: dioTestClient);

      List data = response.body != null
          ? response.body[this.apiResourceName]?.toList() ?? []
          : [];

      return data.map((dataItem) {
        dataItem['dirty'] = false;
        dataItem['synced'] = true;
        ClassMirror classMirror =
            AnnotationReflectable.reflectType(T) as ClassMirror;

        var x = classMirror.newInstance('fromJson', [dataItem]) as T;

        return x;
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> deleteOnline({Dio? dioTestClient}) async {
    final dhisUrl = await this.dhisUrl();

    if (this.id != null) {
      final response = await HttpClient.delete(this.id, dhisUrl,
          database: this.database, dioTestClient: dioTestClient);
      this
          .repository
          .deleteById(id: this.id as String, database: this.database);
      return response.body;
    }

    return {'message': 'Something is wrong'};
  }

  Future<List<T>?> download(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
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

  Future<String> dhisUrl() {
    return Future.value(
        DhisUrlGenerator.generate(this.query, fields: this.selected));
  }
}
