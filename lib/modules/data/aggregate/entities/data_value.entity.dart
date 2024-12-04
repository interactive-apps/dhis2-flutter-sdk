import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';
import 'package:d2_touch/shared/utilities/object.util.dart';

import 'data_value_set.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'datavalue', apiResourceName: 'dataValues')
class DataValue extends IdentifiableEntity {
  @Column(type: ColumnType.TEXT)
  String dataElement;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? attributeOptionCombo;

  @Column(type: ColumnType.TEXT)
  String categoryOptionCombo;

  @Column(type: ColumnType.TEXT)
  String value;

  @Column(nullable: true)
  String? comment;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? synced;

  @ManyToOne(joinColumnName: 'dataValueSet', table: DataValueSet)
  dynamic dataValueSet;

  // @Column("simple-json") categoryCombo: any;
  // @Column("simple-json") dataSetElements: any;
  // @Column("simple-json") organisationUnits: any;

  DataValue(
      {String? id,
      String? created,
      String? lastUpdated,
      String? name,
      required this.dataElement,
      required this.attributeOptionCombo,
      required this.categoryOptionCombo,
      required this.dataValueSet,
      required this.value,
      required this.synced,
      this.comment,
      required dirty})
      : super(
            id: id,
            name: name,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty) {
    this.id =
        '${this.dataElement}_${this.categoryOptionCombo}_${this.dataValueSet}';
    this.name = this.name ?? this.id;
  }

  factory DataValue.fromJson(Map<String, dynamic> json) {
    return DataValue(
        id: json['id'],
        name: json['name'],
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty'],
        dataElement: json['dataElement'],
        attributeOptionCombo: json['attributeOptionCombo'],
        categoryOptionCombo: json['categoryOptionCombo'],
        dataValueSet: json['dataValueSet'],
        value: json['value'],
        comment: json['comment'],
        synced: json['synced']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['name'] = this.name;
    data['dirty'] = this.dirty;
    data['dataElement'] = this.dataElement;
    data['attributeOptionCombo'] = this.attributeOptionCombo;
    data['categoryOptionCombo'] = this.categoryOptionCombo;
    data['dataValueSet'] = this.dataValueSet;
    data['value'] = this.value;
    data['comment'] = this.comment;
    data['synced'] = this.synced;

    return data;
  }

  static toUpload(DataValue dataValue) {
    return ObjectUtil.removeNull({
      "dataElement": dataValue.dataElement,
      "categoryOptionCombo": dataValue.categoryOptionCombo,
      "value": dataValue.value,
      "comment": dataValue.comment
    });
  }
}
