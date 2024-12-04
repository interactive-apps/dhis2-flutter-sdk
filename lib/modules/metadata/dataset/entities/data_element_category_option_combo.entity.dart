// Copyright 2023 UDSM DHIS2 Lab. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_element.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'dataelementcategoryoptioncombo',
    apiResourceName: 'categoryOptionCombos')
class DataElementCategoryOptionCombo extends IdentifiableEntity {
  @Column()
  String categoryOptionCombo;

  @Column(nullable: true)
  bool? ignoreApproval;

  @Column(nullable: true)
  String? displayFormName;

  @ManyToOne(table: DataSetElement, joinColumnName: 'dataSetElement')
  dynamic dataSetElement;

  DataElementCategoryOptionCombo(
      {required String id,
      required this.categoryOptionCombo,
      String? created,
      String? lastUpdated,
      required String name,
      String? displayName,
      String? displayFormName,
      this.ignoreApproval,
      String? code,
      required this.dataSetElement,
      required bool dirty})
      : super(
            id: id,
            name: name,
            displayName: displayName,
            code: code,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty);

  factory DataElementCategoryOptionCombo.fromJson(
      Map<String, dynamic> jsonData) {
    return DataElementCategoryOptionCombo(
        id: jsonData['id'],
        categoryOptionCombo: jsonData['categoryOptionCombo'],
        name: jsonData['name'],
        displayName: jsonData['displayName'],
        displayFormName: jsonData['displayFormName'],
        ignoreApproval: jsonData['ignoreApproval'],
        code: jsonData['code'],
        dataSetElement: jsonData['dataSetElement'],
        dirty: jsonData['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryOptionCombo'] = this.categoryOptionCombo;
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['displayFormName'] = this.displayFormName;
    data['code'] = this.code;
    data['ignoreApproval'] = this.ignoreApproval;
    data['dataSetElement'] = this.dataSetElement;
    data['dirty'] = this.dirty;
    return data;
  }
}
