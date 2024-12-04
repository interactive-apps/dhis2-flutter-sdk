import 'package:d2_touch/core/annotations/reflectable.annotation.dart';
import 'package:d2_touch/core/annotations/relation.annotation.dart';
import 'package:d2_touch/core/utilities/query_expression.dart';
import 'package:reflectable/reflectable.dart';

import 'entity.annotation.dart';

enum ColumnType { TEXT, INTEGER, BOOLEAN, JSON }

enum RelationType { OneToMany, ManyToOne, OneToOne }

class ColumnRelation {
  final RelationType? relationType;
  final String? referencedTable;
  final String? referencedColumn;
  final Entity? referencedEntity;
  final List<Column?>? referencedEntityColumns;
  final String? attributeName;
  final String? primaryKey;
  ColumnRelation(
      {this.relationType,
      this.referencedTable,
      this.referencedColumn,
      this.referencedEntity,
      this.referencedEntityColumns,
      this.attributeName,
      this.primaryKey});
}

@AnnotationReflectable
class Column {
  final ColumnType? type;
  final String? name;
  final int length;
  final int? width;
  final bool nullable;
  final bool readonly;
  final bool unique;
  final bool primary;
  final bool select;
  final bool generated;
  final ColumnRelation? relation;
  final String? attributeName;
  const Column(
      {this.type,
      this.name,
      this.length = 255,
      this.width,
      this.nullable = false,
      this.readonly = false,
      this.unique = false,
      this.primary = false,
      this.select = true,
      this.generated = false,
      this.relation,
      this.attributeName});

  String get columnType {
    return Column.getType(this.type);
  }

  String get columnQueryExpresion {
    return QueryExpression.getColumnExpression(
        name: this.name as String,
        type: this.columnType,
        primary: this.primary,
        nullable: this.nullable);
  }

  static String getType(ColumnType? type) {
    switch (type) {
      case ColumnType.TEXT:
        return 'TEXT';
      case ColumnType.INTEGER:
        return 'INTEGER';
      case ColumnType.BOOLEAN:
        return 'BOOLEAN';
      case ColumnType.JSON:
        return 'JSON';
      default:
        return 'TEXT';
    }
  }

  static ColumnType getColumnType(Type type) {
    switch (type) {
      case String:
        return ColumnType.TEXT;
      case int:
        return ColumnType.INTEGER;
      case bool:
        return ColumnType.BOOLEAN;
      default:
        return ColumnType.TEXT;
    }
  }

  static Column? getColumn(VariableMirror variableMirror, String columnName,
      bool ignoreRelationColumns) {
    if (variableMirror.metadata.isEmpty) {
      return null;
    }

    dynamic variableElement = variableMirror.metadata[0];

    if (variableElement is Column || variableElement is PrimaryColumn) {
      Column column = variableElement;
      return Column(
          type: column.type != null
              ? column.type
              : Column.getColumnType(variableMirror.reflectedType),
          name: column.name != null ? column.name : columnName,
          attributeName: columnName,
          primary: column.primary,
          nullable: column.nullable,
          length: column.length,
          select: column.select,
          unique: column.unique);
    } else if (variableElement is ManyToOne) {
      ManyToOne manyToOneColumn = variableElement;

      return Column(
          type: ColumnType.TEXT,
          name: manyToOneColumn.joinColumnName,
          attributeName: columnName,
          relation: ColumnRelation(
              referencedColumn: 'id',
              attributeName: columnName,
              referencedTable: manyToOneColumn.parentTable,
              relationType: RelationType.ManyToOne,
              referencedEntity: Entity.getEntityDefinition(
                  AnnotationReflectable.reflectType(manyToOneColumn.table)
                      as ClassMirror),
              referencedEntityColumns: ignoreRelationColumns
                  ? null
                  : Entity.getEntityColumns(
                      AnnotationReflectable.reflectType(manyToOneColumn.table)
                          as ClassMirror,
                      ignoreRelationColumns)));
    } else if (variableElement is OneToMany) {
      OneToMany oneToManyColumn = variableElement;

      return Column(
          type: ColumnType.TEXT,
          name: columnName,
          attributeName: columnName,
          relation: ColumnRelation(
              referencedColumn: 'id',
              attributeName: columnName,
              relationType: RelationType.OneToMany,
              referencedEntity: Entity.getEntityDefinition(
                  AnnotationReflectable.reflectType(oneToManyColumn.table)
                      as ClassMirror),
              referencedEntityColumns: Entity.getEntityColumns(
                  AnnotationReflectable.reflectType(oneToManyColumn.table)
                      as ClassMirror,
                  true)));
    } else if (variableElement is OneToOne) {}

    return null;
  }
}

@AnnotationReflectable
class PrimaryColumn extends Column {
  const PrimaryColumn({ColumnType? type}) : super(type: type, primary: true);
}
