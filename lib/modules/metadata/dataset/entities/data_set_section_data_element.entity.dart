// Copyright 2023 UDSM DHIS2 Lab. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/base.entity.dart';

import 'data_set_section.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'datasetsectiondataelement',
    apiResourceName: 'dataSetSectionDataElements')
class DataSetSectionDataElement extends BaseEntity {
  @Column()
  String dataElement;

  @ManyToOne(joinColumnName: 'dataSetSection', table: DataSetSection)
  dynamic dataSetSection;

  DataSetSectionDataElement(
      {required String id,
      required bool dirty,
      String? created,
      String? lastUpdated,
      required this.dataElement,
      required this.dataSetSection})
      : super(id: id, dirty: dirty, created: created, lastUpdated: lastUpdated);

  factory DataSetSectionDataElement.fromJson(Map<String, dynamic> jsonData) {
    return DataSetSectionDataElement(
        id: '${jsonData['dataSetSection']}_${jsonData['dataElement']}',
        dirty: jsonData['dirty'],
        dataElement: jsonData['dataElement'],
        dataSetSection: jsonData['dataSetSection'],
        created: jsonData['created'],
        lastUpdated: jsonData['lastUpdated']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['dataElement'] = this.dataElement;
    data['dataSetSection'] = this.dataSetSection;
    data['dirty'] = this.dirty;
    return data;
  }
}
