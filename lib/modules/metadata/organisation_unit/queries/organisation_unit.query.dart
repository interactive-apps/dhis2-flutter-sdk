import 'package:d2_touch/modules/auth/entities/user_organisation_unit.entity.dart';
import 'package:d2_touch/modules/auth/queries/user_organisation_unit.query.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

class OrganisationUnitQuery extends BaseQuery<OrganisationUnit> {
  bool? includeOtherParentChildren;
  OrganisationUnitQuery({Database? database})
      : super(database: database, junctionOperator: 'OR');

  Future<List<OrganisationUnit>>? getUserOrgUnits() async {
    final List<UserOrganisationUnit> userOrgUnits =
        await UserOrganisationUnitQuery(database: database).get();

    final userOrgUnitIds =
        userOrgUnits.map((orgUnit) => orgUnit.orgUnit).toList();

    return this.byIds(userOrgUnitIds).get();
  }

  includeParentChildren() {
    includeOtherParentChildren = true;
    return this;
  }

  @override
  Future<List<OrganisationUnit>?> download(
    Function(RequestProgress, bool) callback, {
    Dio? dioTestClient,
  }) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message: 'Fetching user assigned organisation units....',
            status: '',
            percentage: 0),
        false);

    final List<UserOrganisationUnit> userOrgUnits =
        await UserOrganisationUnitQuery(database: database).get();

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${userOrgUnits.length} user assigned organisation units found!',
            status: '',
            percentage: 25),
        false);

    this.ilike(
        attribute: 'path',
        value: userOrgUnits
            .map((orgUnit) =>
                includeOtherParentChildren == true && orgUnit.parent != null
                    ? orgUnit.parent as String
                    : orgUnit.orgUnit)
            // ignore: unnecessary_null_comparison
            .where((orgUnit) => orgUnit != null)
            .toList());

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Downloading ${this.apiResourceName?.toLowerCase()} from the server....',
            status: '',
            percentage: 26),
        false);

    String dhisUrl = await this.dhisUrl();

    final response = await HttpClient.get(dhisUrl,
        database: this.database, dioTestClient: dioTestClient);

    List data =
        response.body != null ? response.body[this.apiResourceName] ?? [] : [];

    if (data.isNotEmpty) {
      callback(
          RequestProgress(
              resourceName: this.apiResourceName as String,
              message:
                  '${data.length} ${this.apiResourceName?.toLowerCase()} downloaded successfully',
              status: '',
              percentage: 50),
          false);

      this.data = data.map((dataItem) {
        dataItem['dirty'] = false;
        return OrganisationUnit.fromJson(dataItem);
      }).toList();

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
