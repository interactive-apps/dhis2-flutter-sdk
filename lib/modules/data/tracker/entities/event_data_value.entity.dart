import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

import 'event.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'eventDataValue', apiResourceName: 'dataValues')
class EventDataValue extends IdentifiableEntity {
  @Column()
  String dataElement;

  @Column()
  String value;

  @Column(nullable: true)
  String? storedBy;

  @Column(nullable: true)
  bool? synced;

  @Column(nullable: true)
  bool? providedElsewhere;

  @ManyToOne(joinColumnName: 'event', table: Event)
  dynamic event;

  EventDataValue(
      {String? id,
      required this.dataElement,
      required this.value,
      required this.event,
      required bool dirty,
      this.storedBy,
      String? created,
      String? lastUpdated,
      String? name,
      this.synced,
      this.providedElsewhere})
      : super(
            id: id,
            name: name,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty) {
    this.id = this.id ?? '${this.event}_${this.dataElement}';
    this.name = this.name ?? this.id;
  }

  factory EventDataValue.fromJson(Map<String, dynamic> json) {
    return EventDataValue(
        id: json['id'],
        name: json['id'],
        dataElement: json['dataElement'],
        value: json['value'] ?? '',
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        event: json['event'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dataElement'] = this.dataElement;
    data['value'] = this.value;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['event'] = this.event;
    data['dirty'] = this.dirty;
    return data;
  }

  static toUpload(EventDataValue eventDataValue) {
    return {
      "dataElement": eventDataValue.dataElement,
      "value": eventDataValue.value.replaceAll("\"",
          '') //Replace all helps to sanitize with double quoted strings i.e '"value"' from program rules if any
    };
  }
}
