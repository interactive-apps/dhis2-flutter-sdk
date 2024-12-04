import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_element_category_option_combo.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_element_option.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'datasetelement', apiResourceName: 'dataSetElements')
class DataSetElement extends IdentifiableEntity {
  @Column()
  String dataElementId;

  @ManyToOne(table: DataSet, joinColumnName: 'dataSet')
  dynamic dataSet;

  @OneToMany(table: DataSetElementOption)
  List<DataSetElementOption>? options;

  @OneToMany(table: DataElementCategoryOptionCombo)
  List<DataElementCategoryOptionCombo>? categoryOptionCombos;

  DataSetElement(
      {required String id,
      required String name,
      required bool dirty,
      required this.dataElementId,
      this.dataSet,
      this.options,
      this.categoryOptionCombos})
      : super(id: id, name: name, dirty: dirty);

  factory DataSetElement.fromJson(Map<String, dynamic> json) {
    return DataSetElement(
        id: json['id'],
        name: json['name'],
        dirty: json['dirty'],
        dataSet: json['dataSet'],
        dataElementId: json['dataElementId'],
        options: List<dynamic>.from(
                json['options'] ?? json['optionSet']?['options'] ?? [])
            .map((option) => DataSetElementOption.fromJson({
                  ...option,
                  'id': '${option['id']}_${json['id']}',
                  'dataSetElement': json['id'],
                  'dirty': false
                }))
            .toList(),
        categoryOptionCombos: List<dynamic>.from(json['categoryOptionCombos'] ??
                json['categoryCombo']?['categoryOptionCombos'] ??
                [])
            .map((categoryOptionCombo) =>
                DataElementCategoryOptionCombo.fromJson({
                  ...categoryOptionCombo,
                  'categoryOptionCombo': categoryOptionCombo['categoryOptionCombo'] ?? categoryOptionCombo['id'],
                  'id': '${categoryOptionCombo['id']}_${json['id']}',
                  'dataSetElement': json['id'],
                  'dirty': false
                }))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dirty'] = this.dirty;
    data['dataSet'] = this.dataSet;
    data['dataElementId'] = this.dataElementId;
    data['options'] = this.options;
    data['categoryOptionCombos'] = this.categoryOptionCombos;
    return data;
  }
}
