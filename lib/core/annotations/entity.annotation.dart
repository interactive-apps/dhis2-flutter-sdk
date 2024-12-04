import 'package:d2_touch/core/annotations/column.annotation.dart';
import 'package:d2_touch/core/annotations/reflectable.annotation.dart';
import 'package:reflectable/reflectable.dart';

class EntityOptions {
  final String? name;
  final String? engine;
  final String? schema;
  final bool? synchronize;
  final bool? withoutRowid;
  EntityOptions(
      {this.name,
      this.engine,
      this.schema,
      this.synchronize,
      this.withoutRowid});
}

@AnnotationReflectable
class Entity {
  final String tableName;
  final String apiResourceName;
  final EntityOptions? options;
  final ClassMirror? classMirror;
  const Entity(
      {required this.tableName,
      required this.apiResourceName,
      this.options,
      this.classMirror});

  static Entity getEntityDefinition(ClassMirror entityClassMirror) {
    Entity? entity = entityClassMirror.metadata[1] is Entity
        ? entityClassMirror.metadata[1] as Entity
        : null;

    return Entity(
        tableName: entity?.tableName ?? entityClassMirror.simpleName,
        apiResourceName:
            entity?.apiResourceName ?? entityClassMirror.simpleName,
        classMirror: entityClassMirror,
        options: entity != null ? entity.options : null);
  }

  static List<Column> getEntityColumns(
      ClassMirror entityClassMirror, bool ignoreRelationColumns) {
    List<Column> columns = [];

    for (String key
        in entityClassMirror.superclass!.superclass!.declarations.keys) {
      var value = entityClassMirror.superclass!.superclass!.declarations[key];

      if (value is VariableMirror) {
        VariableMirror variableMirror = value;
        Column? column =
            Column.getColumn(variableMirror, key, ignoreRelationColumns);

        if (column != null) {
          columns.add(column);
        }
      }
    }

    for (String key in entityClassMirror.superclass!.declarations.keys) {
      var value = entityClassMirror.superclass!.declarations[key];

      if (value is VariableMirror) {
        VariableMirror variableMirror = value;
        Column? column =
            Column.getColumn(variableMirror, key, ignoreRelationColumns);

        if (column != null) {
          columns.add(column);
        }
      }
    }

    for (String key in entityClassMirror.declarations.keys) {
      var value = entityClassMirror.declarations[key];
      if (value is VariableMirror) {
        VariableMirror variableMirror = value;
        Column column =
            Column.getColumn(variableMirror, key, ignoreRelationColumns)
                as Column;
        columns.add(column);
      }
    }

    return columns;
  }
}
