import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_data_element.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_section.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class ProgramStageQuery extends BaseQuery<ProgramStage> {
  ProgramStageQuery({Database? database}) : super(database: database);

  ProgramStageQuery withProgram() {
    final program = Repository<Program>(database: database as Database);
    final Column relationColumn = this.repository.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName ==
        program.entity.tableName);

    this.relations.add(relationColumn.relation as ColumnRelation);
    return this;
  }

  ProgramStageQuery withDataElements() {
    final dataElement =
        Repository<ProgramStageDataElement>(database: database as Database);
    final Column? relationColumn = dataElement.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'programStageDataElements',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(ProgramStageDataElement)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(ProgramStageDataElement)
                  as ClassMirror,
              false));
      this.relations.add(relation);
    }

    return this;
  }

  ProgramStageQuery withSections() {
    final programSection =
        Repository<ProgramStageSection>(database: database as Database);
    final Column? relationColumn = programSection.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'programStageSections',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(ProgramStageSection)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(ProgramStageSection)
                  as ClassMirror,
              false));
      this.relations.add(relation);
    }

    return this;
  }
}
