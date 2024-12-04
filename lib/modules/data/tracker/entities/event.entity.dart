import 'dart:convert';

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/data/tracker/models/event_import_summary.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

import 'event_data_value.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'event', apiResourceName: 'events')
class Event extends IdentifiableEntity {
  @Column()
  String? event;

  @Column()
  String status;

  @Column(nullable: true)
  String? eventDate;

  @Column(nullable: true)
  String? dueDate;

  @Column(nullable: true)
  bool? deleted;

  @Column(nullable: true)
  bool? synced;

  @Column(nullable: true)
  bool? syncFailed;

  @Column(nullable: true, type: ColumnType.TEXT)
  EventImportSummary? lastSyncSummary;

  @Column(nullable: true)
  String? lastSyncDate;

  @Column(nullable: true)
  String? storedBy;

  @Column(nullable: true)
  String? coordinate;

  @Column(nullable: true)
  String? trackedEntityInstance;

  @Column(nullable: true)
  String? attributeCategoryOptions;

  @Column(nullable: true)
  String? attributeOptionCombo;

  @Column(nullable: true)
  String? notes;

  /// A value that detects whether the user has marked the entity has saved or not.
  /// This is useful for when you want to sync specific data to remote server and leave others.
  @Column()
  bool? saved;

  @Column(nullable: true)
  String? eventType;

  @ManyToOne(joinColumnName: 'programStage', table: ProgramStage)
  dynamic programStage;

  @ManyToOne(joinColumnName: 'orgUnit', table: OrganisationUnit)
  String orgUnit;

  // @ManyToOne(joinColumnName: 'enrollment', table: Enrollment)
  @Column(nullable: true)
  dynamic enrollment;

  @OneToMany(table: EventDataValue)
  List<EventDataValue>? dataValues;

  Event(
      {String? id,
      String? name,
      String? created,
      String? lastUpdated,
      this.event,
      required this.orgUnit,
      required this.status,
      required dirty,
      this.eventDate,
      this.dueDate,
      this.deleted,
      this.synced,
      this.syncFailed,
      this.lastSyncSummary,
      this.lastSyncDate,
      this.storedBy,
      this.coordinate,
      this.trackedEntityInstance,
      this.attributeCategoryOptions,
      this.attributeOptionCombo,
      this.notes,
      this.saved,
      this.eventType,
      required this.programStage,
      this.enrollment,
      this.dataValues})
      : super(
            id: id,
            name: name,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty) {
    this.event = this.event ?? this.id;
    this.name = this.name ?? this.event;
    this.saved = this.saved ?? false;
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    final dynamic lastSyncSummary = json['lastSyncSummary'] != null
        ? EventImportSummary.fromJson(jsonDecode(json['lastSyncSummary']))
        : null;
    return Event(
        id: json['event'],
        name: json['event'],
        event: json['event'],
        orgUnit: json['orgUnit'],
        status: json['status'],
        eventDate: json['eventDate'],
        dueDate: json['dueDate'],
        deleted: json['deleted'],
        synced: json['synced'],
        saved: json['saved'],
        syncFailed: json['syncFailed'],
        lastSyncSummary: lastSyncSummary,
        lastSyncDate: json['lastSyncDate'],
        storedBy: json['storedBy'],
        coordinate: json['coordinate'],
        trackedEntityInstance: json['trackedEntityInstance'],
        attributeCategoryOptions: json['attributeCategoryOptions'],
        attributeOptionCombo: json['attributeOptionCombo'],
        notes: json['notes'].toString(),
        eventType: json['eventType'],
        programStage: json['programStage'],
        enrollment: json['enrollment'],
        dataValues: List<dynamic>.from(json['dataValues'] ?? [])
            .map((event) => EventDataValue.fromJson({
                  ...event,
                  "id": '${json['event']}_${event['dataElement']}',
                  "event": json['event'],
                  "dirty": json['dirty']
                }))
            .toList(),
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['event'] = this.event;
    data['orgUnit'] = this.orgUnit;
    data['status'] = this.status;
    data['eventDate'] = this.eventDate;
    data['dueDate'] = this.dueDate;
    data['deleted'] = this.deleted;
    data['synced'] = this.synced;
    data['saved'] = this.saved;
    data['syncFailed'] = this.syncFailed;
    data['lastSyncSummary'] = this.lastSyncSummary != null
        ? jsonEncode(
            (this.lastSyncSummary as EventImportSummary).responseSummary)
        : null;
    ;
    data['lastSyncDate'] = this.lastSyncDate;
    data['storedBy'] = this.storedBy;
    data['coordinate'] = this.coordinate;
    data['trackedEntityInstance'] = this.trackedEntityInstance;
    data['attributeCategoryOptions'] = this.attributeCategoryOptions;
    data['attributeOptionCombo'] = this.attributeOptionCombo;
    data['notes'] = this.notes;
    data['eventType'] = this.eventType;
    data['programStage'] = this.programStage;
    data['enrollment'] = this.enrollment;
    data['dataValues'] = this.dataValues;
    data['dirty'] = this.dirty;
    return data;
  }

  static toUpload(Event event) {
    Map<String, dynamic> eventToUpload = {
      "event": event.event,
      "programStage": event.programStage,
      "trackedEntityInstance": event.trackedEntityInstance,
      "orgUnit": event.orgUnit,
      "eventDate": event.eventDate,
      "occurredAt": event.eventDate,
      "status": event.status,
      "storedBy": event.storedBy,
      "coordinate": event.coordinate,
      "enrollment": event.enrollment,
      "dataValues": (event.dataValues ?? [])
          .map((event) => EventDataValue.toUpload(event))
          .toList()
    };

    if (event.programStage != null &&
        event.programStage.runtimeType != String) {
      eventToUpload['programStage'] = event.programStage['id'];
    }

    return eventToUpload;
  }
}
