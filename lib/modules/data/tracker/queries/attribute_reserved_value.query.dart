import 'package:d2_touch/modules/data/tracker/entities/attribute_reserved_value.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_tracked_entity_attribute.entity.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_tracked_entity_attribute.query.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:sqflite/sqflite.dart';

import '../../../metadata/organisation_unit/entities/organisation_unit.entity.dart';
import '../../../metadata/organisation_unit/queries/organisation_unit.query.dart';

class AttributeReservedValueQuery extends BaseQuery<AttributeReservedValue> {
  AttributeReservedValueQuery({Database? database}) : super(database: database);

  @override
  Future<String> dhisUrl() {
    return Future.value(
        'trackedEntityAttributes/attributeID/generateAndReserve?numberToReserve=3');
  }

  @override
  Future<List<AttributeReservedValue>?> download(
      Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message: 'Retrieving reserved attributes from phone database....',
            status: '',
            percentage: 0),
        false);
    List<ProgramTrackedEntityAttribute> reservedAttributes =
        await ProgramTrackedEntityAttributeQuery(database: database)
            .where(attribute: 'generated', value: true)
            .get();

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${reservedAttributes.length} reserved attributes retrieved successfully',
            status: '',
            percentage: 50),
        false);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Downloading and saving reserved values for ${reservedAttributes.length} reserved attributes...',
            status: '',
            percentage: 51),
        false);

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    reservedAttributes.forEach((reservedAttribute) {
      availableItemCount++;
      queue.add(() => downloadReservedValueByAttribute(reservedAttribute,
          dioTestClient: dioTestClient));
    });

    if (availableItemCount == 0) {
      queue.cancel();
    } else {
      await queue.onComplete;
    }

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message: 'Reserved values successfully saved into the database',
            status: '',
            percentage: 100),
        true);
    return await AttributeReservedValueQuery(database: database).get();
  }

  downloadReservedValueByAttribute(
      ProgramTrackedEntityAttribute reservedAttribute,
      {Dio? dioTestClient}) async {
    final int reservedCount =
        await AttributeReservedValueQuery(database: database)
            .where(attribute: 'attribute', value: reservedAttribute.attribute)
            .count();

    final numberToReserve = 100 - reservedCount;

    if (numberToReserve <= 0) {
      return null;
    }

    List<OrganisationUnit>? userOrganisationUnitInfo =
        await OrganisationUnitQuery(database: database).getUserOrgUnits();

    final response;

    if (userOrganisationUnitInfo != null &&
        userOrganisationUnitInfo.isNotEmpty) {
      OrganisationUnit organisationUnit = userOrganisationUnitInfo[0];
      String code = organisationUnit.code ?? '';

      response = await HttpClient.get(
          'trackedEntityAttributes/${reservedAttribute.attribute}/generateAndReserve?numberToReserve=$numberToReserve&ORG_UNIT_CODE=$code',
          database: database,
          dioTestClient: dioTestClient);
    } else {
      response = await HttpClient.get(
          'trackedEntityAttributes/${reservedAttribute.attribute}/generateAndReserve?numberToReserve=$numberToReserve',
          database: database,
          dioTestClient: dioTestClient);
    }

    List<AttributeReservedValue> reservedValues = [];

    for (dynamic reservedResult in response.body ?? []) {
      // ignore: unnecessary_null_comparison
      if (reservedAttribute != null) {
        reservedValues.add(AttributeReservedValue.fromJson(
            {...reservedResult, 'dirty': false}));
      }
    }

    return AttributeReservedValueQuery(database: database)
        .setData(reservedValues)
        .save();
  }
}
