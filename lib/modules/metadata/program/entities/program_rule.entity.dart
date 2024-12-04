import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule_action.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'programrule', apiResourceName: 'programRules')
class ProgramRule extends IdentifiableEntity {
  @Column()
  String condition;

  @Column(nullable: true)
  String? description;

  @ManyToOne(table: Program, joinColumnName: 'program')
  dynamic program;

  @OneToMany(table: ProgramRuleAction)
  List<ProgramRuleAction>? programRuleActions;

  ProgramRule(
      {String? id,
      String? name,
      this.description,
      required this.condition,
      this.program,
      this.programRuleActions,
      required bool dirty})
      : super(id: id, name: name, dirty: dirty);

  factory ProgramRule.fromJson(Map<String, dynamic> json) {
    return ProgramRule(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        condition: json['condition'] ?? '',
        program: json['program'],
        programRuleActions: List<dynamic>.from(json['programRuleActions'] ?? [])
            .map((programRuleAction) => ProgramRuleAction.fromJson({
                  ...programRuleAction,
                  'programRule': json['id'],
                  'dirty': false
                }))
            .toList(),
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['condition'] = this.condition;
    data['program'] = this.program;
    data['programRuleActions'] = this.programRuleActions;
    data['dirty'] = this.dirty;
    return data;
  }
}
