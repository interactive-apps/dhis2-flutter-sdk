import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_data_element.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_section.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'programstage', apiResourceName: 'programStages')
class ProgramStage extends IdentifiableEntity {
  @Column(type: ColumnType.INTEGER)
  int sortOrder;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? executionDateLabel;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? description;

  @Column(type: ColumnType.TEXT)
  String formType;

  @Column(type: ColumnType.BOOLEAN)
  bool blockEntryForm;

  @Column(type: ColumnType.BOOLEAN)
  bool hideDueDate;

  @Column(type: ColumnType.BOOLEAN)
  bool repeatable;

  @Column(nullable: true)
  bool? allowGenerateNextVisit;

  @Column(type: ColumnType.TEXT, nullable: true)
  int? minDaysFromStart;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? generatedByEnrollmentDate;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? autoGenerateEvent;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? captureCoordinates;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? featureType;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? dueDateLabel;

  @OneToMany(table: ProgramStageSection)
  List<ProgramStageSection>? programStageSections;

  @ManyToOne(joinColumnName: 'program', table: Program)
  dynamic program;

  @OneToMany(table: ProgramStageDataElement)
  List<ProgramStageDataElement>? programStageDataElements;

  ProgramStage(
      {required String id,
      String? created,
      String? lastUpdated,
      required String name,
      String? shortName,
      String? code,
      String? displayName,
      this.featureType,
      required this.captureCoordinates,
      required this.sortOrder,
      this.allowGenerateNextVisit,
      required this.autoGenerateEvent,
      required this.blockEntryForm,
      this.dueDateLabel,
      this.executionDateLabel,
      required this.formType,
      required this.generatedByEnrollmentDate,
      required this.hideDueDate,
      required this.minDaysFromStart,
      required this.program,
      this.programStageDataElements,
      this.programStageSections,
      required this.repeatable,
      this.description,
      required dirty})
      : super(
            id: id,
            name: name,
            shortName: shortName,
            displayName: displayName,
            code: code,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory ProgramStage.fromJson(Map<String, dynamic> jsonData) {
    return ProgramStage(
      id: jsonData['id'],
      name: jsonData['name'],
      created: jsonData['created'],
      shortName: jsonData['shortName'],
      code: jsonData['code'],
      displayName: jsonData['displayName'],
      description: jsonData['description'],
      dirty: jsonData['dirty'] ?? false,
      captureCoordinates: jsonData['captureCoordinates'],
      featureType: jsonData['featureType'],
      allowGenerateNextVisit: jsonData['allowGenerateNextVisit'],
      autoGenerateEvent: jsonData['autoGenerateEvent'],
      blockEntryForm: jsonData['blockEntryForm'],
      dueDateLabel: jsonData['dueDateLabel'],
      executionDateLabel: jsonData['executionDateLabel'],
      formType: jsonData['formType'],
      generatedByEnrollmentDate: jsonData['generatedByEnrollmentDate'],
      hideDueDate: jsonData['hideDueDate'],
      minDaysFromStart: int.parse(jsonData['minDaysFromStart'].toString()),
      program: jsonData['program'],
      programStageSections:
          List<dynamic>.from(jsonData['programStageSections'] ?? [])
              .map((programStageSection) => ProgramStageSection.fromJson({
                    ...programStageSection,
                    'programStage': jsonData['id'],
                    'dirty': false
                  }))
              .toList(),
      programStageDataElements: List<dynamic>.from(
              jsonData['programStageDataElements'] ?? [])
          .map((programStageDataElement) => ProgramStageDataElement.fromJson({
                ...programStageDataElement,
                ...(programStageDataElement['dataElement'] ?? {}),
                'id': programStageDataElement['id'],
                'dataElementId': programStageDataElement['dataElement']
                        ?['id'] ??
                    programStageDataElement['dataElementId'],
                'programStage': jsonData['id'],
                'dirty': false
              }))
          .toList(),
      repeatable: jsonData['repeatable'],
      sortOrder: jsonData['sortOrder'] ?? 0,
    );
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
    data['featureType'] = this.featureType;
    data['allowGenerateNextVisit'] = this.allowGenerateNextVisit;
    data['autoGenerateEvent'] = this.autoGenerateEvent;
    data['blockEntryForm'] = this.blockEntryForm;
    data['dueDateLabel'] = this.dueDateLabel;
    data['executionDateLabel'] = this.executionDateLabel;
    data['featureType'] = this.featureType;
    data['formType'] = this.formType;
    data['generatedByEnrollmentDate'] = this.generatedByEnrollmentDate;
    data['hideDueDate'] = this.hideDueDate;
    data['minDaysFromStart'] = this.minDaysFromStart;
    data['program'] = this.program;
    data['programStageDataElements'] = this.programStageDataElements;
    data['programStageSections'] = this.programStageSections;
    data['repeatable'] = this.repeatable;
    data['sortOrder'] = this.sortOrder;
    return data;
  }
}
