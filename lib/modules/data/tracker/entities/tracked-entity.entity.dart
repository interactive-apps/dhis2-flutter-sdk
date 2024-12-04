import 'dart:convert';

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_instance_relationship.entity.dart';
import 'package:d2_touch/modules/data/tracker/models/tracked_entity_instance_import_summary.model.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

import 'enrollment.entity.dart';
import 'event.entity.dart';
import 'tracked_entity_attribute_value.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'trackedEntityInstance',
    apiResourceName: 'trackedEntityInstances')
class TrackedEntityInstance extends IdentifiableEntity {
  @Column()
  String orgUnit;

  @Column()
  String trackedEntityType;

  @Column()
  late String? trackedEntityInstance;

  @Column(nullable: true)
  bool? deleted;

  @Column(nullable: true)
  bool? synced;

  @Column(nullable: true)
  bool? inactive;

  @Column(nullable: true)
  bool? syncFailed;

  @Column(nullable: true)
  bool? transfer;

  @Column(nullable: true, type: ColumnType.TEXT)
  TrackedEntityInstanceImportSummary? lastSyncSummary;

  @Column(nullable: true)
  String? lastSyncDate;

  /// A value that detects whether the user has marked the entity has saved or not.
  /// This is useful for when you want to sync specific data to remote server and leave others.
  @Column()
  bool? saved;

  @OneToMany(table: TrackedEntityAttributeValue)
  List<TrackedEntityAttributeValue>? attributes;

  @OneToMany(table: Enrollment)
  List<Enrollment>? enrollments;

  @OneToMany(table: TrackedEntityInstanceRelationship)
  List<TrackedEntityInstanceRelationship>? relationships;

  TrackedEntityInstance(
      {String? id,
      String? name,
      String? created,
      String? lastUpdated,
      required this.orgUnit,
      required bool dirty,
      required this.trackedEntityType,
      this.trackedEntityInstance,
      this.deleted,
      this.synced,
      this.syncFailed,
      this.lastSyncSummary,
      this.lastSyncDate,
      this.inactive,
      this.enrollments,
      this.attributes,
      this.transfer,
      this.saved,
      this.relationships,
      bool? skipDateUpdate})
      : super(
            id: id,
            name: name,
            created: created,
            lastUpdated: lastUpdated,
            skipDateUpdate: skipDateUpdate,
            dirty: dirty) {
    this.trackedEntityInstance = this.trackedEntityInstance ?? this.id;
    this.saved = this.saved ?? false;
  }

  transferOrgUnit(String orgUnit) {
    this.orgUnit = orgUnit;
    this.transfer = true;
  }

  factory TrackedEntityInstance.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];

    final dynamic lastSyncSummary = json['lastSyncSummary'] != null
        ? TrackedEntityInstanceImportSummary.fromJson(
            jsonDecode(json['lastSyncSummary']))
        : null;

    return TrackedEntityInstance(
        id: json['id'] ?? json['trackedEntityInstance'],
        name: json['trackedEntityInstance'],
        created: json['created'] ?? json['createdAt'],
        lastUpdated: json['lastUpdated'] ?? json['updatedAt'],
        orgUnit: json['orgUnit'],
        trackedEntityInstance: json['trackedEntityInstance'],
        trackedEntityType: json['trackedEntityType'],
        deleted: json['deleted'],
        synced: json['synced'] ?? true,
        saved: json['saved'],
        transfer: json['transfer'],
        syncFailed: json['syncFailed'],
        lastSyncSummary: lastSyncSummary,
        lastSyncDate: json['lastSyncDate'],
        inactive: json['inactive'],
        enrollments: json['enrollments'] != null
            ? List<dynamic>.from(json['enrollments'])
                .map((enrollment) => Enrollment.fromJson({
                      ...enrollment,
                      'trackedEntityType': enrollment['trackedEntityType'] ??
                          json['trackedEntityType'],
                      'dirty': enrollment['dirty'] ?? json['dirty'] ?? false,
                      'synced': json['synced'] ?? true
                    }))
                .toList()
            : null,
        attributes: List<Map<String, dynamic>>.from(attributes ?? [])
            .map((attribute) => TrackedEntityAttributeValue.fromJson({
                  ...attribute,
                  'id': attribute['id'] ??
                      '${json['trackedEntityInstance']}_${attribute['attribute']}',
                  'trackedEntityInstance':
                      json['trackedEntityInstance'] ?? json['trackedEntity'],
                  'dirty': attribute['dirty'] ?? false
                }))
            .toList(),
        relationships: List<dynamic>.from(json['relationships'] ?? [])
            .map((relationship) => TrackedEntityInstanceRelationship.fromJson({
                  ...relationship,
                  'dirty': relationship['dirty'] ?? json['dirty'] ?? false,
                  'synced': json['synced'] ?? true
                }))
            .toList(),
        skipDateUpdate: json['skipDateUpdate'],
        dirty: json['dirty'] ?? false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name ?? this.id;
    data['orgUnit'] = this.orgUnit;
    data['trackedEntityInstance'] = this.trackedEntityInstance;
    data['trackedEntityType'] = this.trackedEntityType;
    data['deleted'] = this.deleted;
    data['synced'] = this.synced;
    data['syncFailed'] = this.syncFailed;
    data['lastSyncSummary'] = this.lastSyncSummary != null
        ? jsonEncode(
            (this.lastSyncSummary as TrackedEntityInstanceImportSummary)
                .responseSummary)
        : null;
    data['lastSyncDate'] = this.lastSyncDate;
    data['inactive'] = this.inactive;
    data['enrollments'] = this.enrollments;
    data['attributes'] = this.attributes;
    data['dirty'] = this.dirty;
    data['saved'] = this.saved;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['transfer'] = this.transfer;
    data['relationships'] = this.relationships;
    return data;
  }

  static toUpload(
      TrackedEntityInstance trackedEntityInstance, List<Event>? events) {
    return {
      "trackedEntityType": trackedEntityInstance.trackedEntityType,
      "orgUnit": trackedEntityInstance.orgUnit,
      "trackedEntityInstance": trackedEntityInstance.trackedEntityInstance,
      "attributes": (trackedEntityInstance.attributes ?? [])
          .map((attribute) => TrackedEntityAttributeValue.toUpload(attribute))
          .toList(),
      "enrollments": toUploadEnrollment(trackedEntityInstance, events),
      "relationships": (trackedEntityInstance.relationships ?? [])
          .map((relationship) =>
              TrackedEntityInstanceRelationship.toUpload(relationship))
          .toList(),
    };
  }

  static toUploadWithoutEnrollment(
      TrackedEntityInstance trackedEntityInstance, List<Event>? events) {
    return {
      "trackedEntityType": trackedEntityInstance.trackedEntityType,
      "orgUnit": trackedEntityInstance.orgUnit,
      "trackedEntityInstance": trackedEntityInstance.trackedEntityInstance,
      "attributes": (trackedEntityInstance.attributes ?? [])
          .map((attribute) => TrackedEntityAttributeValue.toUpload(attribute))
          .toList(),
      "relationships": (trackedEntityInstance.relationships ?? [])
          .map((relationship) =>
              TrackedEntityInstanceRelationship.toUpload(relationship))
          .toList(),
    };
  }

  static toUploadEnrollment(
      TrackedEntityInstance trackedEntityInstance, List<Event>? events) {
    return (trackedEntityInstance.enrollments ?? [])
        .map((enrollment) => Enrollment.toUpload(enrollment, events))
        .toList();
  }
}
