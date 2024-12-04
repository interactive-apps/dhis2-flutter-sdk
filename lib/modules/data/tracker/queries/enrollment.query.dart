import 'package:d2_touch/modules/data/tracker/entities/enrollment.entity.dart';
import 'package:d2_touch/modules/data/tracker/models/enrollment_import_summary.dart';
import 'package:d2_touch/modules/data/tracker/queries/event.query.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/event.entity.dart';

class EnrollmentQuery extends BaseQuery<Enrollment> {
  EnrollmentQuery({Database? database}) : super(database: database);

  Future<List<Enrollment>?> upload(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    List<Enrollment> enrollments = await this
        .where(attribute: 'synced', value: false)
        .where(attribute: 'dirty', value: true)
        .get();

    final List<String> enrollmentIds =
        enrollments.map((enrollment) => enrollment.id as String).toList();

    final List<Event> events = await EventQuery(database: database)
        .whereIn(attribute: 'enrollment', values: enrollmentIds, merge: false)
        .get();

    final enrollmentUploadPayload = enrollments.map((enrollment) {
      return Enrollment.toUpload(enrollment, events);
    }).toList();

    final response = await HttpClient.post(this.apiResourceName as String,
        {'enrollments': enrollmentUploadPayload},
        database: this.database, dioTestClient: dioTestClient);

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
        : (response.body != null && response.body?['response'] != null
                ? response.body?['response']?['importSummaries'] ?? []
                : [])
            .toList();
    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    enrollments.forEach((enrollment) {
      final importSummary = importSummaries.lastWhere((summary) =>
          summary['reference'] != null &&
          summary['reference'] == enrollment.id);

      if (importSummary != null) {
        availableItemCount++;
        final syncFailed = importSummary['status'] == 'ERROR';
        enrollment.synced = !syncFailed;
        enrollment.dirty = syncFailed;
        enrollment.syncFailed = syncFailed;
        enrollment.lastSyncDate = DateTime.now().toIso8601String();
        enrollment.lastSyncSummary =
            EnrollmentImportSummary.fromJson(importSummary);
        queue.add(() =>
            EnrollmentQuery(database: database).setData(enrollment).save());
      }
    });

    if (availableItemCount == 0) {
      queue.cancel();
    } else {
      await queue.onComplete;
    }

    return await EnrollmentQuery(database: database).byIds(enrollmentIds).get();
  }
}
