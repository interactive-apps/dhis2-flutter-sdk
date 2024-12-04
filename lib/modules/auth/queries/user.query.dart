import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/entities/user_authority.entity.dart';
import 'package:d2_touch/modules/auth/entities/user_group_user.entity.dart';
import 'package:d2_touch/modules/auth/entities/user_organisation_unit.entity.dart';
import 'package:d2_touch/modules/auth/entities/user_role.entity.dart';
import 'package:d2_touch/modules/auth/queries/user_group_users.query.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:dio/dio.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

import '../../../shared/models/request_progress.model.dart';
import '../../../shared/utilities/dhis-url-generator.util.dart';
import '../../../shared/utilities/http_client.util.dart';

class UserQuery extends BaseQuery<User> {
  List<String>? userGroupsId;
  bool userOrgUnits;
  bool includeChildren;
  String? filterMode;
  UserQuery(
      {Database? database,
      this.userGroupsId,
      this.filterMode,
      this.includeChildren = false,
      this.userOrgUnits = false})
      : super(database: database);

  UserQuery withOrganisationUnit() {
    final userOrganisationUnit =
        Repository<UserOrganisationUnit>(database: database as Database);
    final Column? relationColumn = userOrganisationUnit.columns.firstWhere(
        (column) =>
            column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'organisationUnits',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(UserOrganisationUnit)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(UserOrganisationUnit)
                  as ClassMirror,
              false));
      this.relations.add(relation);
    }

    return this;
  }

  UserQuery withAuthorities() {
    final userAuthority =
        Repository<UserAuthority>(database: database as Database);
    final Column? relationColumn = userAuthority.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'authorities',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(UserAuthority) as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(UserAuthority) as ClassMirror,
              false));
      this.relations.add(relation);
    }

    return this;
  }

  UserQuery withRoles() {
    final userRole = Repository<UserRole>(database: database as Database);
    final Column? relationColumn = userRole.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'roles',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(UserRole) as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(UserRole) as ClassMirror,
              false));
      this.relations.add(relation);
    }

    return this;
  }

  byGroups({required List<String> userGroupsId, required String filterMode}) {
    this.filterMode = filterMode;
    this.userGroupsId = userGroupsId;
    return this;
  }

  byUserOrgUnits() {
    this.filterMode = filterMode;
    this.userOrgUnits = true;
    this.includeChildren = true;
    return this;
  }

  @override
  Future<List<User>?> download(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Downloading ${this.apiResourceName?.toLowerCase()} from the server....',
            status: '',
            percentage: 0),
        false);

    final dhisUrl = await this.dhisUrl();
    final response = await HttpClient.get(dhisUrl,
        database: this.database, dioTestClient: dioTestClient);

    List data =
        response.body != null && response.body[this.apiResourceName] != null
            ? response.body[this.apiResourceName]?.toList()
            : [];
    if (response.body == null || response.body[this.apiResourceName] == null) {
      callback(
          RequestProgress(
              resourceName: this.apiResourceName as String,
              message:
                  'Downloading ${this.apiResourceName} failed with status code ${response.statusCode}',
              status: '',
              percentage: 0),
          false);
    }

    if (data.isEmpty) {
      callback(
          RequestProgress(
              resourceName: this.apiResourceName as String,
              message: 'No ${this.apiResourceName} found.',
              status: '',
              percentage: 0),
          true);
    }

    if (data.isNotEmpty) {
      this.data = data.map((dataItem) {
        dataItem['dirty'] = false;
        dataItem['synced'] = true;
        return User.fromApi(dataItem);
      }).toList();

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

      final List<UserGroupUser> userGroupsList = [];

      for (var user in data) {
        for (var userGroup in user['userGroups']) {
          final group = {
            'id': '${user['id']}_${userGroup['id']}',
            'userId': user['id'],
            'groupId': userGroup['id']
          };

          userGroupsList.add(UserGroupUser.fromJson(group));
        }
      }

      await UserGroupUserQuery(database: database)
          .setData(userGroupsList)
          .save();

      callback(
          RequestProgress(
              resourceName: this.apiResourceName as String,
              message: data.isNotEmpty
                  ? '${data.length} ${this.apiResourceName?.toLowerCase()} successfully saved into the database'
                  : 'No ${this.apiResourceName} found.',
              status: '',
              percentage: 100),
          true);
    }

    return this.data;
  }

  @override
  Future<String> dhisUrl() {
    final apiFields = DhisUrlGenerator.getApiFields(this.query.columns);

    String apiFilter = '';

    if (userGroupsId != null && filterMode != null)
      apiFilter = 'filter=userGroups.$filterMode:in:$userGroupsId';

    return Future.value(
        '${this.query.resourceName}.json${apiFilter != "" ? '?$apiFilter&' : '?'}fields=${(this.selected.isNotEmpty ? this.selected : apiFields).join(',')}&userOrgUnits=${this.userOrgUnits}&includeChildren=${this.includeChildren}&paging=false');
  }
}
