import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/utilities/dhis_uid_generator.util.dart';

// @AnnotationReflectable
class BaseEntity {
  @PrimaryColumn()
  late String? id;

  @Column()
  bool dirty;

  @Column(nullable: true)
  String? lastUpdated;

  @Column(nullable: true)
  String? created;

  bool? skipDateUpdate;

  BaseEntity(
      {this.id,
      required this.dirty,
      this.created,
      this.lastUpdated,
      this.skipDateUpdate = false}) {
    this.id = this.id ?? DhisUidGenerator.generate();
    this.created = this.created ?? DateTime.now().toIso8601String();
    this.lastUpdated = this.lastUpdated ?? this.created;

    if (dirty &&
        (skipDateUpdate == null || skipDateUpdate == false) &&
        lastUpdated == null) {
      this.lastUpdated = DateTime.now().toIso8601String();
    }
  }

  static fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
