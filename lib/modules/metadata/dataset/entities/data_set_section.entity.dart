// Copyright 2023 UDSM DHIS2 Lab. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_section_data_element.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_section_greyed_field.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'datasetsection', apiResourceName: 'dataSetSections')
class DataSetSection extends IdentifiableEntity {
  @Column()
  int sortOrder;

  @Column(nullable: true)
  bool? showRowTotals;

  @ManyToOne(joinColumnName: 'dataSet', table: DataSet)
  dynamic dataSet;

  @OneToMany(table: DataSetSectionDataElement)
  List<DataSetSectionDataElement>? dataElements;

  @OneToMany(table: DataSetSectionGreyedField)
  List<DataSetSectionGreyedField>? greyedFields;

  DataSetSection(
      {required String id,
      required bool dirty,
      required String created,
      required String lastUpdated,
      required String name,
      required String displayName,
      required this.sortOrder,
      this.showRowTotals,
      required this.dataSet,
      this.dataElements,
      this.greyedFields})
      : super(
          id: id,
          dirty: dirty,
          created: created,
          lastUpdated: lastUpdated,
          name: name,
          displayName: displayName,
        );

  factory DataSetSection.fromJson(Map<String, dynamic> jsonData) {
    return DataSetSection(
        id: jsonData['id'],
        dirty: jsonData['dirty'],
        created: jsonData['created'],
        lastUpdated: jsonData['lastUpdated'],
        name: jsonData['name'],
        displayName: jsonData['displayName'],
        showRowTotals: jsonData['showRowTotals'],
        sortOrder: jsonData['sortOrder'],
        dataSet: jsonData['dataSet'],
        dataElements: List<dynamic>.from(jsonData['dataElements'] ?? [])
            .map((dataElement) => DataSetSectionDataElement.fromJson({
                  ...dataElement,
                  'dataElement': dataElement['dataElement'],
                  'dataSetSection': jsonData['id'],
                  'dirty': false
                }))
            .toList(),
        greyedFields: List<dynamic>.from(jsonData['greyedFields'] ?? [])
            .map((greyedField) => DataSetSectionGreyedField.fromJson({
                  ...greyedField,
                  'dataSetSection': jsonData['id'],
                  'dirty': false
                }))
            .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['showRowTotals'] = this.showRowTotals;
    data['sortOrder'] = this.sortOrder;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['dataSet'] = this.dataSet;
    data['dirty'] = this.dirty;
    data['dataElements'] = this.dataElements;
    data['greyedFields'] = this.greyedFields;
    return data;
  }
}
