import 'package:d2_touch/shared/entities/base.entity.dart';
import 'package:d2_touch/core/annotations/index.dart';

@AnnotationReflectable
@Entity(tableName: 'dataStore', apiResourceName: 'dataStores')
class DataStore extends BaseEntity {
  @Column()
  String namespace;

  @Column()
  String key;

  @Column()
  String value;

  DataStore({
    required this.namespace,
    required this.key,
    required this.value,
    String? id,
    String? created,
    String? lastUpdated,
    required bool dirty,
  }) : super(dirty: dirty, id: id, created: created, lastUpdated: lastUpdated);

  factory DataStore.fromJson(Map<String, dynamic> json) {
    return DataStore(
        namespace: json['namespace'],
        key: json['key'],
        value: json['value'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson(){
    final data = new Map<String, dynamic>();

    data['namespace'] = this.namespace;
    data['key'] = this.key;
    data['value'] = this.value;
    data['id'] = this.id;
    data['dirty'] = this.dirty;
    return data;
  }
}
