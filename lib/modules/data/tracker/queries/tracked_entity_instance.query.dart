import 'dart:core';

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/auth/queries/user_organisation_unit.query.dart';
import 'package:d2_touch/modules/data/tracker/entities/attribute_reserved_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/enrollment.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/event.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_instance_relationship.entity.dart';
import 'package:d2_touch/modules/data/tracker/models/tracked_entity_instance_import_summary.model.dart';
import 'package:d2_touch/modules/data/tracker/queries/attribute_reserved_value.query.dart';
import 'package:d2_touch/modules/data/tracker/queries/enrollment.query.dart';
import 'package:d2_touch/modules/data/tracker/queries/event.query.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_relationship.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_tracked_entity_attribute.entity.dart';
import 'package:d2_touch/modules/metadata/program/queries/program.query.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_relationship.query.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:d2_touch/shared/utilities/orgunit_mode.util.dart';
import 'package:d2_touch/shared/utilities/query_filter.util.dart';
import 'package:d2_touch/shared/utilities/query_filter_condition.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:reflectable/mirrors.dart';
import 'package:sqflite/sqflite.dart';

class TrackedEntityInstanceQuery extends BaseQuery<TrackedEntityInstance> {
  String? orgUnit;
  String? program;
  bool? useUserOrgUnit;
  OrgUnitMode? ouMode;

  TrackedEntityInstanceQuery({Database? database}) : super(database: database);
  List<QueryFilter>? attributeFilters = [];

  TrackedEntityInstanceQuery withAttributes() {
    final attributeValue =
        Repository<TrackedEntityAttributeValue>(database: database as Database);

    final Column? relationColumn = attributeValue.columns.firstWhere((column) {
      return column.relation?.referencedEntity?.tableName == this.tableName;
    });

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'attributes',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(TrackedEntityAttributeValue)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(TrackedEntityAttributeValue)
                  as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }

  TrackedEntityInstanceQuery withEnrollments() {
    final enrollment = Repository<Enrollment>(database: database as Database);
    final Column? relationColumn = enrollment.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'enrollments',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(Enrollment) as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(Enrollment) as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }

  TrackedEntityInstanceQuery withRelationships() {
    final relationship = Repository<TrackedEntityInstanceRelationship>(
        database: database as Database);
    final Column? relationColumn = relationship.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'relationships',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(
                  TrackedEntityInstanceRelationship) as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(
                  TrackedEntityInstanceRelationship) as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }

  TrackedEntityInstanceQuery byOrgUnit(String orgUnit) {
    this.orgUnit = orgUnit;
    return this.where(attribute: 'orgUnit', value: orgUnit);
  }

  TrackedEntityInstanceQuery byAttribute(
      String attributeId, String attibuteValue) {
    List<QueryFilter>? existingFilterForSameAttribute = this
        .attributeFilters
        ?.where((element) => element.attribute == attributeId)
        .toList();
    if (existingFilterForSameAttribute?.length == 0) {
      this.attributeFilters?.add(QueryFilter(
          attribute: attributeId,
          condition: QueryCondition.Equal,
          value: attibuteValue));
    } else {
      QueryFilter newQueryFilter = QueryFilter(
          attribute: attributeId,
          condition: QueryCondition.In,
          value:
              '${existingFilterForSameAttribute?[0].value};${attibuteValue}');

      this
          .attributeFilters
          ?.removeWhere((element) => element.attribute == attributeId);
      this.attributeFilters?.add(newQueryFilter);
    }

    return this;
  }

  TrackedEntityInstanceQuery byProgram(String program) {
    this.program = program;
    return this;
  }

  TrackedEntityInstanceQuery withOuMode(OrgUnitMode ouMode) {
    this.ouMode = ouMode;
    return this;
  }

  TrackedEntityInstanceQuery byUserOrgUnit() {
    this.useUserOrgUnit = true;
    return this;
  }

  @override
  get({Dio? dioTestClient, bool? online}) async {
    if (this.program != null) {
      EnrollmentQuery enrollmentQuery = EnrollmentQuery(database: database);

      enrollmentQuery.where(attribute: 'program', value: this.program);

      if (this.orgUnit != null) {
        enrollmentQuery.where(attribute: 'orgUnit', value: this.orgUnit);
      }

      List<Enrollment> enrollments = await enrollmentQuery.get();

      if (enrollments.isEmpty) {
        return [];
      }

      List<String> trackedEntityAttributeIds = [];

      enrollments.forEach((enrollment) {
        String? availableId;

        try {
          availableId = trackedEntityAttributeIds.firstWhere(
            (id) => enrollment.trackedEntityInstance == id,
          );
        } catch (e) {}

        if (availableId == null) {
          trackedEntityAttributeIds.add(enrollment.trackedEntityInstance);
        }
      });

      this.byIds(trackedEntityAttributeIds);

      return this.repository.findAll(
          database: this.database,
          filters: this.filters,
          fields: this.fields,
          sortOrder: this.sortOrder,
          relations: this.relations) as Future<List<TrackedEntityInstance>>;
    }

    if (this.id != null) {
      return this.repository.find(
          id: this.id,
          fields: this.fields,
          database: this.database,
          relations: this.relations) as Future<List<TrackedEntityInstance>>;
    }

    return this.repository.findAll(
        database: this.database,
        filters: this.filters,
        fields: this.fields as List<String>,
        sortOrder: this.sortOrder,
        relations: this.relations) as Future<List<TrackedEntityInstance>>;
  }

  @override
  Future create() async {
    final Program program = await ProgramQuery(database: database)
        .byId(this.program as String)
        .withAttributes()
        .getOne();

    TrackedEntityInstance trackedEntityInstance = TrackedEntityInstance(
      orgUnit: this.orgUnit as String,
      dirty: false,
      trackedEntityType: program.trackedEntityType as String,
    );

    Enrollment enrollment = Enrollment(
        trackedEntityType: program.trackedEntityType as String,
        orgUnit: this.orgUnit as String,
        program: program.id as String,
        trackedEntityInstance: trackedEntityInstance.trackedEntityInstance,
        status: 'ACTIVE',
        dirty: true);

    trackedEntityInstance.enrollments = [enrollment];

    final List<ProgramTrackedEntityAttribute> reservedAttributes =
        (program.programTrackedEntityAttributes ?? [])
            .where((attribute) => attribute.generated == true)
            .toList();

    List<TrackedEntityAttributeValue> attributeValues = [];

    await Future.wait(reservedAttributes.map((attribute) async {
      final AttributeReservedValue? attributeReservedValue =
          await AttributeReservedValueQuery(database: database)
              .where(attribute: 'attribute', value: attribute.attribute)
              .getOne();

      if (attributeReservedValue != null) {
        final String id =
            '${trackedEntityInstance.trackedEntityInstance}_${attribute.attribute}';
        attributeValues.add(TrackedEntityAttributeValue(
            id: id,
            name: id,
            dirty: true,
            attribute: attribute.attribute,
            trackedEntityInstance: trackedEntityInstance.trackedEntityInstance,
            value: attributeReservedValue.value));

        await AttributeReservedValueQuery(database: database)
            .byId(attributeReservedValue.id as String)
            .delete();
      }

      return null;
    }));

    trackedEntityInstance.attributes = attributeValues;

    this.data = trackedEntityInstance;

    await this.save();

    return trackedEntityInstance;
  }

  Future<String> dhisUrl() async {
    if (this.useUserOrgUnit == true) {
      final userOrgUnits =
          await UserOrganisationUnitQuery(database: database).get();

      this.orgUnit =
          userOrgUnits.map((userOrgUnit) => userOrgUnit.orgUnit).join(';');
    }

    String orgUnitMode = 'ouMode=';

    switch (this.ouMode) {
      case OrgUnitMode.DESCENDANTS:
        orgUnitMode += 'DESCENDANTS';
        break;
      case OrgUnitMode.CHILDREN:
        orgUnitMode += 'CHILDREN';
        break;
      case OrgUnitMode.SELECTED:
        orgUnitMode += 'SELECTED';
        break;
      case OrgUnitMode.ACCESSIBLE:
        orgUnitMode += 'ACCESSIBLE';
        break;
      default:
        orgUnitMode += 'SELECTED';
        break;
    }

    String url =
        'trackedEntityInstances.json?ou=${this.orgUnit}&$orgUnitMode&program=${this.program}&pageSize=50&order=created:desc&fields=${(this.selected).isNotEmpty ? this.selected.join(',') : '*'}${this.attributeFilters?.length == 0 ? "" : "&" + (this.attributeFilters?.map((queryFilterItem) {
              return "filter=" +
                  queryFilterItem.attribute +
                  (queryFilterItem.condition == QueryCondition.In
                      ? ":IN:"
                      : ":EQ:") +
                  queryFilterItem.value;
            }).join("&") as String)}';

    return Future.value(url);
  }

  @override
  Future<List<TrackedEntityInstance>?> download(
      Function(RequestProgress, bool) callback,
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

    if ((data ?? []).isNotEmpty) {
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

      List<TrackedEntityInstanceRelationship> relationships = [];
      data.forEach((dataItem) {
        relationships = [...relationships, ...dataItem.relationships];
      });

      if (relationships.length > 0) {
        await downloadRelatedTrackedEntityInstances(
            relationships: relationships, dioTestClient: dioTestClient);
      }

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

  Future<List<TrackedEntityInstance>> downloadRelatedTrackedEntityInstances(
      {required List<TrackedEntityInstanceRelationship> relationships,
      Dio? dioTestClient}) async {
    final requests = (await Future.wait(relationships.map((relationship) async {
      ProgramRelationship? programRelationship =
          await ProgramRelationshipQuery(database: database)
              .byId(relationship.relationshipType)
              .getOne();

      Map<String, dynamic> resultMap = {};
      resultMap['trackedEntityInstance'] = relationship.toTrackedInstance;
      resultMap['program'] = programRelationship?.toProgram;

      return programRelationship?.toProgram != null ? resultMap : null;
    })))
        .skipWhile((value) => value == null);

    Map<String, List<String>> requestByProgram = {};
    requests.forEach((request) {
      if (request != null && request['program'] != null) {
        requestByProgram[request['program']] = [
          ...(requestByProgram[request['program']] ?? []),
          request['trackedEntityInstance']
        ];
      }
    });

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;
    requestByProgram.keys.forEach((String program) {
      availableItemCount++;
      queue.add(() => downloadByProgramAndInstances(
          program: program,
          trackedEntityInstances: requestByProgram[program] as List<String>,
          dioTestClient: dioTestClient));
    });

    if (availableItemCount == 0) {
      queue.cancel();
    } else {
      await queue.onComplete;
    }

    return [];
  }

  Future downloadByProgramAndInstances(
      {required String program,
      required List<String> trackedEntityInstances,
      Dio? dioTestClient}) async {
    final dhisUrl =
        'trackedEntityInstances.json?program=${program}&fields=${(this.selected).isNotEmpty ? this.selected.join(',') : '*'}&trackedEntityInstance=${trackedEntityInstances.join(";")}';

    final response = await HttpClient.get(dhisUrl,
        database: this.database, dioTestClient: dioTestClient);
    // if (response.body != null && response.body.runtimeType){}
    data = response.body != null && response.body[this.apiResourceName] != null
        ? response.body[this.apiResourceName]?.toList()
        : [];

    List<TrackedEntityInstance> trackedEntityInstanceData =
        data.map<TrackedEntityInstance>((dataItem) {
      Map<String, dynamic> dataMap = dataItem as Map<String, dynamic>;
      dataMap['dirty'] = false;
      dataMap['synced'] = true;

      return TrackedEntityInstance.fromJson(dataMap);
    }).toList();

    await TrackedEntityInstanceQuery(database: database)
        .setData(trackedEntityInstanceData)
        .save();
  }

  Future<List<TrackedEntityInstance>?> upload(
      Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Retrieving ${this.apiResourceName?.toLowerCase()} from phone database....',
            status: '',
            percentage: 0),
        false);
    List<TrackedEntityInstance> trackedEntityInstances = await this
        .withAttributes()
        .withEnrollments()
        .withRelationships()
        .where(attribute: 'synced', value: false)
        .where(attribute: 'dirty', value: true)
        .get();

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${trackedEntityInstances.length} ${this.apiResourceName?.toLowerCase()} retrieved successfully',
            status: '',
            percentage: 50),
        false);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Uploading ${trackedEntityInstances.length} ${this.apiResourceName?.toLowerCase()} into the server...',
            status: '',
            percentage: 51),
        false);

    List<String> enrollmentIds = [];

    final List<String> trackedEntityInstanceIds =
        trackedEntityInstances.map((trackedEntityInstance) {
      trackedEntityInstance.enrollments?.forEach((enrollment) {
        if (enrollment.id != null) {
          enrollmentIds.add(enrollment.id as String);
        }
      });

      return trackedEntityInstance.id as String;
    }).toList();

    final List<Event> events = await EventQuery(database: database)
        .whereIn(attribute: 'enrollment', values: enrollmentIds, merge: false)
        .withDataValues()
        .get();

    List<dynamic> trackedEntityInstanceUploadPayload =
        trackedEntityInstances.map((trackedEntityInstance) {
      return TrackedEntityInstance.toUpload(trackedEntityInstance, events);
    }).toList();

    if (trackedEntityInstanceUploadPayload[0]['enrollments'][0]['events']
            .length !=
        0) {
      trackedEntityInstanceUploadPayload[0]['enrollments'][0]['events']
          .forEach((event) {
        event['eventDate'] = event['eventDate'].toString().split('T')[0];
      });
    }

    HttpResponse response = await HttpClient.post(
        this.apiResourceName as String,
        {'trackedEntityInstances': trackedEntityInstanceUploadPayload},
        database: this.database,
        dioTestClient: dioTestClient);

    if (response.statusCode == 500) {
      trackedEntityInstanceUploadPayload =
          trackedEntityInstances.map((trackedEntityInstance) {
        return TrackedEntityInstance.toUploadWithoutEnrollment(
            trackedEntityInstance, events);
      }).toList();

      response = await HttpClient.post(this.apiResourceName as String,
          {'trackedEntityInstances': trackedEntityInstanceUploadPayload},
          database: this.database, dioTestClient: dioTestClient);

      await HttpClient.post(
          "enrollments",
          {
            'enrollments': trackedEntityInstances.map((trackedEntityInstance) {
              return TrackedEntityInstance.toUploadEnrollment(
                  trackedEntityInstance, events);
            }).toList()
          },
          database: this.database,
          dioTestClient: dioTestClient);
    }

    final List<Future<HttpResponse>> transferApis = trackedEntityInstances
        .where((tei) => tei.transfer == true)
        .map((teiToTransfer) => HttpClient.put(
            "tracker/ownership/transfer?trackedEntityInstance=${teiToTransfer.trackedEntityInstance}&program=${teiToTransfer.enrollments?[0].program as String}&ou=${teiToTransfer.orgUnit}",
            null,
            database: this.database,
            dioTestClient: dioTestClient))
        .toList();

    await Future.wait(transferApis);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Upload for ${trackedEntityInstances.length} ${this.apiResourceName?.toLowerCase()} is completed.',
            status: '',
            percentage: 75),
        true);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message: 'Saving import summaries into the phone database...',
            status: '',
            percentage: 76),
        true);

    final List<dynamic> importSummaries = response.body.runtimeType == String
        ? [
            {
              "responseType": "ImportSummary",
              "status": "ERROR",
              "reference": "",
              "enrollments": {
                "responseType": "ImportSummary",
                "status": "ERROR",
                "imported": 0,
                "updated": 0,
                "ignored": 1,
                "deleted": 0,
                "importSummaries:": [],
                "total": 0
              },
              "importCount": {
                "imported": 0,
                "updated": 0,
                "ignored": 1,
                "deleted": 0
              },
              "total": 0,
              "importSummaries:": [],
              "conflicts": [
                {
                  "object": "Server.ERROR",
                  "value": '${response.body.toString()}: ${response.statusCode}'
                }
              ]
            }
          ]
        : (response.body?['response']?['importSummaries'] ?? []).toList();

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    trackedEntityInstances.forEach((trackedEntityInstance) {
      bool syncFailed = true;
      if (!((response.statusCode >= 200 && response.statusCode < 300) ||
          response.statusCode == 409)) {
        syncFailed = true;
        trackedEntityInstance.lastSyncSummary =
            TrackedEntityInstanceImportSummary.fromJson({
          "responseType": "ImportSummary",
          "status": "ERROR",
          "reference": "",
          "enrollments": {
            "responseType": "ImportSummary",
            "status": "ERROR",
            "imported": 0,
            "updated": 0,
            "ignored": 1,
            "deleted": 0,
            "importSummaries:": [],
            "total": 0
          },
          "importCount": {
            "imported": 0,
            "updated": 0,
            "ignored": 1,
            "deleted": 0
          },
          "total": 0,
          "importSummaries:": [],
          "conflicts": [
            {
              "object": "Server.ERROR",
              "value": response.body.runtimeType == String
                  ? response.body.toString()
                  : response.body['message'] ??
                      "Server Error code:" + response.statusCode.toString()
            }
          ]
        });
      } else {
        final importSummary = importSummaries.lastWhere(
            (summary) => summary['reference'] == trackedEntityInstance.id,
            orElse: (() => null));
        if (importSummary != null) {
          syncFailed = importSummary['status'] == 'ERROR';
          trackedEntityInstance.lastSyncSummary =
              TrackedEntityInstanceImportSummary.fromJson(importSummary);
        } else {
          syncFailed = true;
          trackedEntityInstance.lastSyncSummary =
              TrackedEntityInstanceImportSummary.fromJson({
            "responseType": "ImportSummary",
            "status": "ERROR",
            "reference": "",
            "enrollments": {
              "responseType": "ImportSummary",
              "status": "ERROR",
              "imported": 0,
              "updated": 0,
              "ignored": 1,
              "deleted": 0,
              "importSummaries:": [],
              "total": 0
            },
            "importCount": {
              "imported": 0,
              "updated": 0,
              "ignored": 1,
              "deleted": 0
            },
            "total": 0,
            "importSummaries:": [],
            "conflicts": [
              {
                "object": "ImportSummary.DOES_NOT_EXIST",
                "value": response.body['message'] ?? "Invalid Import Summary"
              }
            ]
          });
        }
      }
      availableItemCount++;
      trackedEntityInstance.synced = !syncFailed;
      trackedEntityInstance.dirty = true;
      trackedEntityInstance.syncFailed = syncFailed;
      trackedEntityInstance.lastSyncDate = DateTime.now().toIso8601String();

      queue.add(() => TrackedEntityInstanceQuery(database: database)
          .setData(trackedEntityInstance)
          .save());
    });

    if (availableItemCount == 0) {
      queue.cancel();
    } else {
      await queue.onComplete;
    }

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message: 'Import summaries saved succussfully',
            status: '',
            percentage: 100),
        true);

    return await TrackedEntityInstanceQuery(database: database)
        .byIds(trackedEntityInstanceIds)
        .get();
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
