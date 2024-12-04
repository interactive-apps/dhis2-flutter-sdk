import 'dart:convert';

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'fileResource', apiResourceName: 'fileResources')
class FileResource extends IdentifiableEntity {
  @Column(nullable: true)
  String? resourceId;

  @Column()
  String elementId;

  @Column()
  String elementType;

  @Column()
  String formInstance;

  @Column()
  String contentType;

  @Column(nullable: true)
  String? contentLength;

  @Column(nullable: true)
  String? storageStatus;

  @Column()
  String localFilePath;

  @Column(nullable: true)
  bool? synced;

  @Column(nullable: true)
  bool? syncFailed;

  @Column(nullable: true)
  String? lastSyncSummary;

  @Column(nullable: true)
  String? lastSyncDate;

  FileResource(
      {String? id,
      required this.elementId,
      required this.formInstance,
      required this.elementType,
      this.resourceId,
      String? name,
      required this.contentType,
      this.contentLength,
      required this.storageStatus,
      required this.localFilePath,
      this.synced,
      this.syncFailed,
      this.lastSyncSummary,
      this.lastSyncDate,
      String? created,
      String? lastUpdated,
      required bool dirty})
      : super(
            id: id,
            name: name,
            dirty: dirty,
            created: created,
            lastUpdated: lastUpdated) {
    this.id = this.id ?? '${this.formInstance}_${this.elementId}';
    this.name = this.name ?? this.localFilePath;
  }

  factory FileResource.fromJson(Map<String, dynamic> json) {
    const JsonEncoder encoder = JsonEncoder();
    final dynamic lastSyncSummary = encoder.convert(json['lastSyncSummary']);
    return FileResource(
        id: json['id'],
        elementId: json['elementId'],
        elementType: json['elementType'],
        formInstance: json['formInstance'],
        resourceId: json['resourceId'],
        name: json['name'],
        contentType: json['contentType'],
        contentLength: json['contentLength'],
        storageStatus: json['storageStatus'],
        localFilePath: json['localFilePath'],
        synced: json['synced'],
        syncFailed: json['syncFailed'],
        lastSyncSummary: lastSyncSummary,
        lastSyncDate: json['lastSyncDate'],
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty'] ?? false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['elementId'] = this.elementId;
    data['elementType'] = this.elementType;
    data['formInstance'] = this.formInstance;
    data['resourceId'] = this.resourceId;
    data['name'] = this.name;
    data['contentType'] = this.contentType;
    data['contentLength'] = this.contentLength;
    data['storageStatus'] = this.storageStatus;
    data['localFilePath'] = this.localFilePath;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['synced'] = this.synced;
    data['syncFailed'] = this.syncFailed;
    data['lastSyncSummary'] = this.lastSyncSummary;
    data['lastSyncDate'] = this.lastSyncDate;
    data['dirty'] = this.dirty;
    return data;
  }
}
