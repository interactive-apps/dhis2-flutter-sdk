import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_element_category_option_combo.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_element.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_element_option.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class DataSetElementQuery extends BaseQuery<DataSetElement> {
  DataSetElementQuery({Database? database}) : super(database: database);

  DataSetElementQuery withOptions() {
    final dataElementOption =
        Repository<DataSetElementOption>(database: database as Database);

    final Column? relationColumn = dataElementOption.columns.firstWhere(
        (column) =>
            column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'options',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(DataSetElementOption)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(DataSetElementOption)
                  as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }

  DataSetElementQuery withCategoryOptionCombos() {
    final categoryOptionCombo = Repository<DataElementCategoryOptionCombo>(
        database: database as Database);

    final Column? relationColumn = categoryOptionCombo.columns.firstWhere(
        (column) =>
            column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'categoryOptionCombos',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(DataElementCategoryOptionCombo)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(DataElementCategoryOptionCombo)
                  as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }
}
