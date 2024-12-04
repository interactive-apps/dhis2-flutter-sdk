import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_section.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_section_attribute.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqlite_api.dart';

class ProgramSectionQuery extends BaseQuery<ProgramSection> {
  ProgramSectionQuery({Database? database}) : super(database: database);

  ProgramSectionQuery withAttributes() {
    final programSectionAttribute =
        Repository<ProgramSectionAttribute>(database: database as Database);
    final Column? relationColumn = programSectionAttribute.columns.firstWhere(
        (column) =>
            column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'attributes',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(ProgramSectionAttribute)
                  as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(ProgramSectionAttribute)
                  as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }
}
