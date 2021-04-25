import 'package:dhis2_flutter_sdk/core/annotations/index.dart';
import 'package:dhis2_flutter_sdk/shared/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

@AnnotationReflectable
@Entity(tableName: 'dataelement')
class DataElement extends BaseEntity {
  @Column(type: ColumnType.TEXT, name: 'formname', nullable: true)
  String formName;

  @Column(type: ColumnType.TEXT, name: 'valuetype', length: 50)
  String valueType;

  @Column(type: ColumnType.TEXT, name: 'aggregationtype', length: 50)
  String aggregationType;

  @Column(type: ColumnType.TEXT, name: 'description', nullable: true)
  String description;

  DataElement(
      {@required String id,
      String created,
      String lastUpdated,
      @required String name,
      @required String shortName,
      String code,
      String displayName,
      this.formName,
      @required this.aggregationType,
      this.description,
      @required this.valueType,
      @required dirty})
      : super(
            id: id,
            name: name,
            shortName: shortName,
            displayName: displayName,
            code: code,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory DataElement.fromJson(Map<String, dynamic> json) {
    return DataElement(
        id: json['id'],
        name: json['name'],
        created: json['created'],
        shortName: json['shortname'],
        code: json['code'],
        displayName: json['displayname'],
        valueType: json['valuetype'],
        aggregationType: json['aggregationtype'],
        description: json['description'],
        dirty: json['dirty']);
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
    data['valueType'] = this.valueType;
    data['aggregationType'] = this.aggregationType;
    data['description'] = this.description;
    data['dirty'] = this.dirty;

    return data;
  }
}