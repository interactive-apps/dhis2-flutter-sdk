// Copyright 2023 UDSM DHIS2 Lab. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:d2_touch/core/annotations/column.annotation.dart';
import 'package:d2_touch/core/annotations/entity.annotation.dart';
import 'package:d2_touch/core/annotations/reflectable.annotation.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_section.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_section_data_element.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_section_greyed_field.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class DataSetSectionQuery extends BaseQuery<DataSetSection> {
  DataSetSectionQuery({Database? database}) : super(database: database);

  DataSetSectionQuery withDataElements() {
    final dataSetSectionDataElement =
        Repository<DataSetSectionDataElement>(database: database as Database);

    final Column? relationColumn = dataSetSectionDataElement.columns.firstWhere(
        (column) =>
            column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'dataElements',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(DataSetSectionDataElement)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(DataSetSectionDataElement)
                  as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }

  DataSetSectionQuery withGreyedFields() {
    final dataSetSectionGreyedField =
        Repository<DataSetSectionGreyedField>(database: database as Database);

    final Column? relationColumn = dataSetSectionGreyedField.columns.firstWhere(
        (column) =>
            column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'greyedFields',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(DataSetSectionGreyedField)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(DataSetSectionGreyedField)
                  as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }
}
