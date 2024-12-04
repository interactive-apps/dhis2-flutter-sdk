import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'programRelationship', apiResourceName: 'relationshipTypes')
class ProgramRelationship extends IdentifiableEntity {
  @Column()
  String fromProgram;

  @Column()
  String toProgram;

  ProgramRelationship(
      {String? id,
      String? displayName,
      String? name,
      required this.fromProgram,
      required this.toProgram,
      required bool dirty})
      : super(id: id, name: name, displayName: displayName, dirty: dirty);

  factory ProgramRelationship.fromJson(Map<String, dynamic> json) {
    return ProgramRelationship(
        id: json['id'],
        name: json['name'],
        displayName: json['displayName'],
        fromProgram: json['fromProgram'] ?? json['fromConstraint']['program']['id'],
        toProgram: json['toProgram'] ?? json['toConstraint']['program']['id'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['fromProgram'] = this.fromProgram;
    data['toProgram'] = this.toProgram;
    data['dirty'] = this.dirty;

    return data;
  }
}
