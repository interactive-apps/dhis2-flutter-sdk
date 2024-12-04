import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/data/tracker/entities/event.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/event_data_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/models/event_import_summary.dart';
import 'package:d2_touch/modules/data/tracker/models/response.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_touch/modules/metadata/program/queries/program_stage.query.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class EventQuery extends BaseQuery<Event> {
  int? instanceVersion;
  String? orgUnit;
  String? program;
  String? programStage;
  String? enrollment;

  EventQuery({Database? database, this.instanceVersion})
      : super(database: database);

  EventQuery withDataValues() {
    final eventDataValue =
        Repository<EventDataValue>(database: database as Database);

    final Column? relationColumn = eventDataValue.columns.firstWhere((column) {
      return column.relation?.referencedEntity?.tableName == this.tableName;
    });

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'dataValues',
          primaryKey: primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(EventDataValue) as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(EventDataValue) as ClassMirror,
              false));

      relations.add(relation);
    }

    return this;
  }

  EventQuery withProgramStage() {
    final programStage =
        Repository<ProgramStage>(database: database as Database);
    final Column relationColumn = repository.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName ==
        programStage.entity.tableName);

    relations.add(relationColumn.relation as ColumnRelation);

    return this;
  }

  EventQuery byOrgUnit(String orgUnit) {
    this.orgUnit = orgUnit;
    return this.where(attribute: 'orgUnit', value: orgUnit);
  }

  EventQuery byProgram(String program) {
    this.program = program;
    return this;
  }

  EventQuery byProgramStage(String programStage) {
    this.programStage = programStage;
    return this.where(attribute: 'programStage', value: programStage);
  }

  EventQuery byEnrollment(String enrollment) {
    this.enrollment = enrollment;
    return this.where(attribute: 'enrollment', value: enrollment);
  }

  @override
  Future<String> dhisUrl() {
    if ((this.selected).isNotEmpty) {
      return Future.value(
          'events.json?fields=${this.selected.join(',')}&orgUnit=${this.orgUnit}&program=${this.program}${this.programStage != null ? '&programStage=${this.programStage}' : ''}&order=eventDate:desc&pageSize=100&page=1');
    }
    return Future.value(
        'events.json?fields=event,eventDate,dueDate,program,programStage,orgUnit,trackedEntityInstance,enrollment,enrollmentStatus,status,attributeCategoryOptions,lastUpdated,created,followup,deleted,attributeOptionCombo,dataValues[dataElement,value,lastUpdated,created,storedBy,providedElseWhere]&orgUnit=${this.orgUnit}&program=${this.program}${this.programStage != null ? '&programStage=${this.programStage}' : ''}&order=eventDate:desc&pageSize=100&page=1');
  }

  @override
  Future create() async {
    Event event = Event(
        orgUnit: this.orgUnit as String,
        status: 'ACTIVE',
        enrollment: this.enrollment ?? '',
        dirty: true,
        synced: false,
        programStage: this.programStage,
        eventDate: DateTime.now().toIso8601String());

    this.data = event;

    await this.save();

    return event;
  }

  Future<List<Event>?> upload(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient, String? resource}) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Retrieving ${this.apiResourceName?.toLowerCase()} from phone database....',
            status: '',
            percentage: 0),
        false);
    List<Event> events = await this
        .where(attribute: 'synced', value: false)
        .where(attribute: 'dirty', value: true)
        .withDataValues()
        .get();

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${events.length} ${this.apiResourceName?.toLowerCase()} retrieved successfully',
            status: '',
            percentage: 50),
        false);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Uploading ${events.length} ${this.apiResourceName?.toLowerCase()} into the server...',
            status: '',
            percentage: 51),
        false);

    List<String> eventIds = events.map((event) => event.id as String).toList();

    final eventUploadPayload = [];
    for (Event event in events) {
      if (event.programStage != null) {
        ProgramStage programStage = await ProgramStageQuery(database: database)
            .byId(event.programStage)
            .getOne();
        dynamic eventPayload = Event.toUpload(event);
        eventPayload['program'] = programStage.program;
        eventUploadPayload.add(eventPayload);
      } else {
        dynamic eventPayload = Event.toUpload(event);
        eventUploadPayload.add(eventPayload);
      }
    }

    final response = await HttpClient.post(
        resource ?? this.apiResourceName as String,
        {'events': eventUploadPayload},
        database: this.database,
        dioTestClient: dioTestClient);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Upload for ${events.length} ${this.apiResourceName?.toLowerCase()} is completed.',
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
        : response.body['status'] != null &&
                response.body['status'] == 'OK' &&
                response.body['validationReport'] != null
            ? [
                {
                  "responseType": "ImportSummary",
                  "status": "SUCCESS",
                  "reference": eventIds[0],
                  "enrollments": {
                    "responseType": "ImportSummary",
                    "status": "ERROR",
                    "imported": 0,
                    "updated": 1,
                    "ignored": 0,
                    "deleted": 0,
                    "importSummaries:": [
                      {
                        "responseType": "ImportSummary",
                        "status": "SUCCESS",
                        "importCount": {
                          "imported": 0,
                          "updated": 1,
                          "ignored": 0,
                          "deleted": 0
                        },
                        "conflicts": [],
                        "reference": "a6vUjBH0UUj"
                      }
                    ],
                    "total": 0
                  },
                  "importCount": {
                    "imported": 1,
                    "updated": 1,
                    "ignored": 0,
                    "deleted": 0
                  },
                  "total": 1,
                  "importSummaries:": [],
                  "conflicts": []
                }
              ]
            : (response.body?['response']?['importSummaries'] ?? []).toList();

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    if (instanceVersion != null && instanceVersion! >= 38) {
      final lastestVersionResponse =
          LatestVersionResponse.fromJson(response.body);

      final objectReport = lastestVersionResponse
          .bundleReport?.typeReportMap?.event?.objectReports;

      events.forEach((event) {
        final importSummary =
            objectReport?.lastWhere((summary) => summary.uid == event.id);
        if (importSummary != null) {
          availableItemCount++;
          final syncFailed = lastestVersionResponse.status == 'ERROR';
          event.synced = !syncFailed;
          event.dirty = true;
          event.syncFailed = syncFailed;
          event.lastSyncDate = DateTime.now().toIso8601String();
          event.lastUpdated = DateTime.now().toIso8601String();
          queue.add(() => EventQuery(database: database).setData(event).save());
        }
      });
    } else {
      events.forEach((event) {
        final importSummary = importSummaries.lastWhere(
          (summary) =>
              summary['reference'] != null && summary['reference'] == event.id,
          orElse: () => null,
        );

        if (importSummary != null) {
          availableItemCount++;
          final syncFailed = importSummary['status'] == 'ERROR';
          event.synced = !syncFailed;
          event.dirty = true;
          event.syncFailed = syncFailed;
          event.lastSyncDate = DateTime.now().toIso8601String();
          event.lastUpdated = DateTime.now().toIso8601String();
          event.lastSyncSummary = EventImportSummary.fromJson(importSummary);

          queue.add(() => EventQuery(database: database).setData(event).save());
        }
      });
    }

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

    return await EventQuery(database: database).byIds(eventIds).get();
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}
