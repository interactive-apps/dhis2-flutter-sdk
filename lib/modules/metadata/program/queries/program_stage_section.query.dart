import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_section.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_section_data_element.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class ProgramStageSectionQuery extends BaseQuery<ProgramStageSection> {
  ProgramStageSectionQuery({Database? database}) : super(database: database);

  ProgramStageSectionQuery withDataElements() {
    final programStageSectionDataElement =
        Repository<ProgramStageSectionDataElement>(
            database: database as Database);
    final Column? relationColumn = programStageSectionDataElement.columns
        .firstWhere((column) =>
            column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'dataElements',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(ProgramStageSectionDataElement)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(ProgramStageSectionDataElement)
                  as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }
}
