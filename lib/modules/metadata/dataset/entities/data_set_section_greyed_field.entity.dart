// Copyright 2023 UDSM DHIS2 Lab. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/base.entity.dart';

import 'data_set_section.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'datasetsectiongreyedfield',
    apiResourceName: 'dataSetSectionGreyedFields')
class DataSetSectionGreyedField extends BaseEntity {
  @Column()
  String dimensionItem;

  @ManyToOne(joinColumnName: 'dataSetSection', table: DataSetSection)
  dynamic dataSetSection;

  DataSetSectionGreyedField(
      {required bool dirty,
      String? id,
      String? lastUpdated,
      String? created,
      required this.dimensionItem,
      required this.dataSetSection})
      : super(dirty: dirty, id: id, created: created, lastUpdated: lastUpdated);

  factory DataSetSectionGreyedField.fromJson(Map<String, dynamic> jsonData) {
    return DataSetSectionGreyedField(
        id: '${jsonData['dataSetSection']}_${jsonData['id']}',
        dirty: jsonData['dirty'],
        dimensionItem: jsonData['dimensionItem'],
        dataSetSection: jsonData['dataSetSection'],
        created: jsonData['created'],
        lastUpdated: jsonData['lastUpdated']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['dimensionItem'] = this.dimensionItem;
    data['dataSetSection'] = this.dataSetSection;
    data['dirty'] = this.dirty;
    return data;
  }
}
