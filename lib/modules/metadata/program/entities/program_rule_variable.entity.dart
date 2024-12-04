import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'programrulevariable', apiResourceName: 'programRuleVariables')
class ProgramRuleVariable extends IdentifiableEntity {
  @Column()
  String programRuleVariableSourceType;

  @Column(nullable: true)
  bool? useCodeForOptionSet;

  @ManyToOne(table: Program, joinColumnName: 'program')
  dynamic program;

  @Column(nullable: true)
  String? dataElement;

  @Column(nullable: true)
  String? option;

  @Column(nullable: true)
  String? section;

  @Column(nullable: true)
  String? trackedEntityAttribute;

  ProgramRuleVariable(
      {String? id,
      String? name,
      String? displayName,
      required this.programRuleVariableSourceType,
      this.program,
      this.useCodeForOptionSet,
      this.dataElement,
      this.trackedEntityAttribute,
      this.option,
      this.section,
      required bool dirty})
      : super(id: id, name: name, displayName: displayName, dirty: dirty);

  factory ProgramRuleVariable.fromJson(Map<String, dynamic> json) {
    return ProgramRuleVariable(
        id: json['id'],
        name: json['name'],
        displayName: json['displayName'],
        programRuleVariableSourceType: json['programRuleVariableSourceType'],
        useCodeForOptionSet: json['useCodeForOptionSet'],
        dataElement: json['dataElement'] != null
            ? json['dataElement'] is String
                ? json['dataElement']
                : json['dataElement']['id']
            : null,
        trackedEntityAttribute: json['trackedEntityAttribute'] != null
            ? json['trackedEntityAttribute'] is String
                ? json['trackedEntityAttribute']
                : json['trackedEntityAttribute']['id']
            : null,
        program: json['program'],
        option: json['option'] != null
            ? json['option'] is String
                ? json['option']
                : json['option']['id']
            : null,
        section: json['section'] != null
            ? json['section'] is String
                ? json['section']
                : json['section']['id']
            : null,
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['useCodeForOptionSet'] = this.useCodeForOptionSet;
    data['dataElement'] = this.dataElement;
    data['trackedEntityAttribute'] = this.trackedEntityAttribute;
    data['programRuleVariableSourceType'] = this.programRuleVariableSourceType;
    data['program'] = this.program;
    data['option'] = this.option;
    data['section'] = this.section;
    data['dirty'] = this.dirty;
    return data;
  }
}
