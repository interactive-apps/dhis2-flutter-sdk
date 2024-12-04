import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

import 'tracked-entity.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'trackedEntityAttributeValue', apiResourceName: 'attributes')
class TrackedEntityAttributeValue extends IdentifiableEntity {
  @Column()
  String attribute;
  @Column()
  String value;
  @Column()
  bool? synced;

  @ManyToOne(
      joinColumnName: 'trackedEntityInstance', table: TrackedEntityInstance)
  dynamic trackedEntityInstance;

  TrackedEntityAttributeValue(
      {String? id,
      String? name,
      String? created,
      String? lastUpdated,
      required bool dirty,
      required this.attribute,
      required this.trackedEntityInstance,
      required this.value,
      this.synced})
      : super(
            id: id,
            name: name,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty) {
    this.id = '${this.trackedEntityInstance}_${this.attribute}';
    this.name = this.id;
  }

  factory TrackedEntityAttributeValue.fromJson(Map<String, dynamic> json) {
    return TrackedEntityAttributeValue(
        id: json['id'],
        name: json['id'],
        attribute: json['attribute'],
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        trackedEntityInstance: json['trackedEntityInstance'],
        value: json['value'],
        dirty: json['dirty'] ?? false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['attribute'] = this.attribute;
    data['value'] = this.value;
    data['trackedEntityInstance'] = this.trackedEntityInstance;
    data['dirty'] = this.dirty;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    return data;
  }

  static toUpload(TrackedEntityAttributeValue attribute) {
    return {
      "attribute": attribute.attribute,

      //Replace all helps to sanitize with double quoted strings i.e '"value"' from program rules if any
      "value": attribute.value.replaceAll("\"", '')
    };
  }
}
