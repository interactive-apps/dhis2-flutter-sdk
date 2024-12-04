import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule_variable.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_section.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

import 'program_tracked_entity_attribute.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'program', apiResourceName: 'programs')
class Program extends IdentifiableEntity {
  @Column(type: ColumnType.TEXT)
  String programType;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? displayIncidentDate;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? description;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? withoutRegistration;

  @Column(type: ColumnType.BOOLEAN)
  bool ignoreOverdueEvents;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? captureCoordinates;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? featureType;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? enrollmentDateLabel;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? onlyEnrollOnce;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? selectIncidentDatesInFuture;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? selectEnrollmentDatesInFuture;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? useFirstStageDuringRegistration;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? incidentDateLabel;

  @Column(type: ColumnType.INTEGER, nullable: true)
  int? completeEventsExpiryDays;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? displayFrontPageList;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? trackedEntity;

  @Column(nullable: true)
  String? trackedEntityType;

  @Column(nullable: true)
  Object? organisationUnits;

  // @OneToMany(() => ProgramStageEntity, (programStage) => programStage.program, {
  //   cascade: true,
  // })
  // programStages: ProgramStageEntity[];

  // @OneToMany(() => ProgramIndicatorEntity, (programIndicator) => programIndicator.program, {
  //   cascade: true,
  // })
  // programIndicators: ProgramIndicatorEntity[];

  @OneToMany(table: ProgramTrackedEntityAttribute)
  List<ProgramTrackedEntityAttribute>? programTrackedEntityAttributes;

  @OneToMany(table: ProgramRuleVariable)
  List<ProgramRuleVariable>? programRuleVariables;

  @OneToMany(table: ProgramStage)
  List<ProgramStage>? programStages;

  @OneToMany(table: ProgramSection)
  List<ProgramSection>? programSections;

  Program(
      {required String id,
      String? created,
      String? lastUpdated,
      required String name,
      required String shortName,
      String? code,
      String? displayName,
      required this.programType,
      this.featureType,
      this.captureCoordinates,
      this.completeEventsExpiryDays,
      this.displayFrontPageList,
      this.displayIncidentDate,
      this.enrollmentDateLabel,
      required this.ignoreOverdueEvents,
      this.incidentDateLabel,
      this.onlyEnrollOnce,
      this.organisationUnits,
      this.programRuleVariables,
      this.programStages,
      this.programSections,
      this.selectEnrollmentDatesInFuture,
      this.description,
      this.selectIncidentDatesInFuture,
      this.trackedEntity,
      this.trackedEntityType,
      this.useFirstStageDuringRegistration,
      this.withoutRegistration,
      this.programTrackedEntityAttributes,
      required bool dirty})
      : super(
            id: id,
            name: name,
            shortName: shortName,
            displayName: displayName,
            code: code,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory Program.fromJson(Map<String, dynamic> json) {
    final trackedEntityType = json['trackedEntityType'] != null
        ? json['trackedEntityType'] is String
            ? json['trackedEntityType']
            : json['trackedEntityType']['id'] ?? json['trackedEntityType']
        : null;

    return Program(
        id: json['id'],
        name: json['name'],
        created: json['created'],
        shortName: json['shortName'],
        code: json['code'],
        displayName: json['displayName'],
        description: json['description'],
        dirty: json['dirty'] ?? false,
        captureCoordinates: json['captureCoordinates'],
        completeEventsExpiryDays: json['completeEventsExpiryDays'],
        displayFrontPageList: json['displayFrontPageList'],
        displayIncidentDate: json['displayIncidentDate'],
        enrollmentDateLabel: json['enrollmentDateLabel'],
        featureType: json['featureType'],
        ignoreOverdueEvents: json['ignoreOverdueEvents'],
        incidentDateLabel: json['incidentDateLabel'],
        onlyEnrollOnce: json['onlyEnrollOnce'],
        organisationUnits: json['organisationUnits']?.toString() ?? null,
        programRuleVariables: List<dynamic>.from(json['programRuleVariables'] ?? [])
            .map((programRuleVariable) => ProgramRuleVariable.fromJson(
                {...programRuleVariable, 'program': json['id'], 'dirty': false}))
            .toList(),
        programType: json['programType'],
        selectEnrollmentDatesInFuture: json['selectEnrollmentDatesInFuture'],
        selectIncidentDatesInFuture: json['selectIncidentDatesInFuture'],
        trackedEntity: json['trackedEntity'],
        trackedEntityType: trackedEntityType,
        useFirstStageDuringRegistration:
            json['useFirstStageDuringRegistration'],
        withoutRegistration: json['withoutRegistration'],
        programStages: List<dynamic>.from(json['programStages'] ?? [])
            .map((programStage) => ProgramStage.fromJson(
                {...programStage, 'program': json['id'], 'dirty': false}))
            .toList(),
        programSections: List<dynamic>.from(json['programSections'] ?? [])
            .map((programSection) => ProgramSection.fromJson(
                {...programSection, 'program': json['id'], 'dirty': false}))
            .toList(),
        programTrackedEntityAttributes:
            List<dynamic>.from(json['programTrackedEntityAttributes'] ?? [])
                .map((programTrackedEntityAttribute) =>
                    ProgramTrackedEntityAttribute.fromJson(
                        {...programTrackedEntityAttribute, 'program': json['id'], 'dirty': false}))
                .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['shortName'] = this.shortName;
    data['code'] = this.code;
    data['displayName'] = this.displayName;
    data['description'] = this.description;
    data['dirty'] = this.dirty;
    data['captureCoordinates'] = this.captureCoordinates;
    data['completeEventsExpiryDays'] = this.completeEventsExpiryDays;
    data['displayFrontPageList'] = this.displayFrontPageList;
    data['displayIncidentDate'] = this.displayIncidentDate;
    data['enrollmentDateLabel'] = this.enrollmentDateLabel;
    data['featureType'] = this.featureType;
    data['ignoreOverdueEvents'] = this.ignoreOverdueEvents;
    data['incidentDateLabel'] = this.incidentDateLabel;
    data['onlyEnrollOnce'] = this.onlyEnrollOnce;
    data['organisationUnits'] = this.organisationUnits;
    data['programStages'] = this.programStages;
    data['programSections'] = this.programSections;
    data['programTrackedEntityAttributes'] =
        this.programTrackedEntityAttributes;
    data['programRuleVariables'] = this.programRuleVariables;
    data['programType'] = this.programType;
    data['selectEnrollmentDatesInFuture'] = this.selectEnrollmentDatesInFuture;
    data['selectIncidentDatesInFuture'] = this.selectIncidentDatesInFuture;
    data['trackedEntity'] = this.trackedEntity;
    data['trackedEntityType'] = this.trackedEntityType;
    data['useFirstStageDuringRegistration'] =
        this.useFirstStageDuringRegistration;
    data['withoutRegistration'] = this.withoutRegistration;
    return data;
  }
}
