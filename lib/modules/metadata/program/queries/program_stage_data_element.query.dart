import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_data_element.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_data_element_option.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class ProgramStageDataElementQuery extends BaseQuery<ProgramStageDataElement> {
  ProgramStageDataElementQuery({Database? database})
      : super(database: database);

  ProgramStageDataElementQuery withOptions() {
    final dataElementOption = Repository<ProgramStageDataElementOption>(
        database: database as Database);

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
              AnnotationReflectable.reflectType(ProgramStageDataElementOption)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(ProgramStageDataElementOption)
                  as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }
}
