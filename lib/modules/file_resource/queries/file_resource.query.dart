import 'package:d2_touch/modules/data/tracker/entities/event_data_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/queries/event_data_value.query.dart';
import 'package:d2_touch/modules/data/tracker/queries/tracked_entity_attribute_value.query.dart';
import 'package:d2_touch/modules/file_resource/entities/file_resource.entity.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:queue/queue.dart';
import 'package:sqflite/sqflite.dart';

class FileResourceQuery extends BaseQuery<FileResource> {
  FileResourceQuery({Database? database}) : super(database: database);

  Future<List<FileResource>?> upload(Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Retrieving ${this.apiResourceName?.toLowerCase()} from phone database....',
            status: '',
            percentage: 0),
        false);
    List<FileResource> fileResources =
        await this.where(attribute: 'synced', value: false).get();

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${fileResources.length} ${this.apiResourceName?.toLowerCase()} retrieved successfully',
            status: '',
            percentage: 50),
        false);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Uploading ${fileResources.length} ${this.apiResourceName?.toLowerCase()} into the server...',
            status: '',
            percentage: 51),
        false);

    final uploadQueue = Queue(parallel: 50);
    num availableUploadItemCount = 0;
    List fileResourceResponses = [];

    fileResources.forEach((fileResource) async {
      final mimeType =
          lookupMimeType(fileResource.localFilePath)?.split('/') ?? [];
      availableUploadItemCount++;
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(fileResource.localFilePath,
            contentType: MediaType(mimeType[0], mimeType[1]))
      });
      uploadQueue.add(() async {
        final fileResourceResponse = await HttpClient.post(
            this.apiResourceName as String, formData,
            database: this.database, dioTestClient: dioTestClient);
        fileResourceResponses.add({
          'fileResourceId': fileResource.id,
          'fileResourceResponse': fileResourceResponse.body
        });
        return fileResourceResponse;
      });
    });

    if (availableUploadItemCount == 0) {
      uploadQueue.cancel();
    } else {
      await uploadQueue.onComplete;
    }

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Upload for ${fileResources.length} ${this.apiResourceName?.toLowerCase()} is completed.',
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

    final queue = Queue(parallel: 50);
    final formValueUpdateQueue = Queue(parallel: 50);
    num availableItemCount = 0;
    num availableElementCount = 0;

    fileResources.forEach((fileResource) {
      final fileResourceResponse = fileResourceResponses.lastWhere(
          (response) => response['fileResourceId'] == fileResource.id,
          orElse: (() => null));

      if (fileResourceResponse != null) {
        final importSummary = fileResourceResponse['fileResourceResponse'];
        availableItemCount++;
        final resourceId = importSummary['response']?['fileResource']?['id'];

        final syncFailed = importSummary['status'] != 'OK';
        fileResource.synced = !syncFailed;
        fileResource.dirty = true;
        fileResource.syncFailed = syncFailed;
        fileResource.resourceId = resourceId;
        fileResource.storageStatus =
            importSummary['response']?['fileResource']?['storageStatus'];
        fileResource.lastSyncDate = DateTime.now().toIso8601String();
        fileResource.lastSyncSummary = importSummary.toString();
        queue.add(() =>
            FileResourceQuery(database: database).setData(fileResource).save());

        if (resourceId != null) {
          switch (fileResource.elementType) {
            case 'TRACKED_ENTITY_ATTRIBUTE':
              availableElementCount++;
              formValueUpdateQueue.add(() => this
                  .updateTrackedEntityAttributeValue(
                      attribute: fileResource.elementId,
                      trackedEntityInstance: fileResource.formInstance,
                      resourceId: resourceId));
              break;
            case 'DATA_ELEMENT':
              availableElementCount++;
              formValueUpdateQueue.add(() => this.updateDataElementValue(
                  dataElement: fileResource.elementId,
                  event: fileResource.formInstance,
                  resourceId: resourceId));
              break;
            default:
              break;
          }
        }
      }
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
            percentage: 85),
        true);

    if (availableElementCount == 0) {
      formValueUpdateQueue.cancel();
    } else {
      await formValueUpdateQueue.onComplete;
    }

    return await FileResourceQuery(database: database)
        .byIds(fileResources
            .map((fileResource) => fileResource.id as String)
            .toList())
        .get();
  }

  Future<dynamic> updateTrackedEntityAttributeValue(
      {required String attribute,
      required String trackedEntityInstance,
      required String resourceId}) async {
    TrackedEntityAttributeValue? trackedEntityAttributeValue =
        await TrackedEntityAttributeValueQuery(database: database)
            .where(attribute: 'attribute', value: attribute)
            .where(
                attribute: 'trackedEntityInstance',
                value: trackedEntityInstance)
            .getOne();

    if (trackedEntityAttributeValue == null) {
      final newTrackedEntityAttributeValue = TrackedEntityAttributeValue(
          dirty: true,
          attribute: attribute,
          trackedEntityInstance: trackedEntityInstance,
          value: resourceId);

      return await TrackedEntityAttributeValueQuery(database: database)
          .setData(newTrackedEntityAttributeValue)
          .save();
    }

    trackedEntityAttributeValue.value = resourceId;
    return await TrackedEntityAttributeValueQuery(database: database)
        .setData(trackedEntityAttributeValue)
        .save();
  }

  Future<dynamic> updateDataElementValue(
      {required String dataElement,
      required String event,
      required String resourceId}) async {
    EventDataValue? eventDataValue =
        await EventDataValueQuery(database: database)
            .where(attribute: 'dataElement', value: dataElement)
            .where(attribute: 'event', value: event)
            .getOne();

    if (eventDataValue == null) {
      final newEventDataValue = EventDataValue(
          dataElement: dataElement,
          value: resourceId,
          event: event,
          dirty: true);

      return await EventDataValueQuery(database: database)
          .setData(newEventDataValue)
          .save();
    }

    eventDataValue.value = resourceId;
    return await EventDataValueQuery(database: database)
        .setData(eventDataValue)
        .save();
  }
}
