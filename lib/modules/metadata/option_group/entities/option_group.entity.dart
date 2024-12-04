import 'dart:convert';

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'optiongroup', apiResourceName: 'optionGroups')
class OptionGroup extends IdentifiableEntity {
  @Column(type: ColumnType.TEXT)
  String options;

  OptionGroup({
    required String id,
    required String name,
    required bool dirty,
    required this.options,
  }) : super(id: id, name: name, dirty: dirty);

  factory OptionGroup.fromJson(Map<String, dynamic> jsonData) {
    return OptionGroup(
      id: jsonData['id'],
      name: jsonData['name'],
      dirty: jsonData['dirty'],
      options: jsonEncode(jsonData['options']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dirty'] = this.dirty;
    data['options'] = this.options;
    return data;
  }
}
