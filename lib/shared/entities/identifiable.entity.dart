import 'dart:convert';

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/models/translation.model.dart';
import 'package:d2_touch/shared/entities/base.entity.dart';

@AnnotationReflectable
class IdentifiableEntity extends BaseEntity {
  @Column()
  String? name;

  @Column(nullable: true)
  final String? displayName;

  @Column(nullable: true)
  final String? shortName;

  @Column(nullable: true)
  final String? code;

  @Column(nullable: true, type: ColumnType.TEXT)
  dynamic translations;

  IdentifiableEntity(
      {String? id,
      required bool dirty,
      this.name,
      this.displayName,
      this.shortName,
      String? lastUpdated,
      String? created,
      this.code,
      this.translations,
      bool? skipDateUpdate})
      : super(
            id: id,
            dirty: dirty,
            created: created,
            lastUpdated: lastUpdated,
            skipDateUpdate: skipDateUpdate) {
    if (this.translations != null) {
      this.translations = translations is String
          ? jsonDecode(this.translations)
          : this.translations;
    }
  }

  Translation? get translation {
    return this.translations != null
        ? Translation(translationString: this.translations as List<dynamic>)
        : null;
  }
}
