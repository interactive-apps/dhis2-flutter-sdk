import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:d2_touch/shared/entities/base.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'trackedEntityInstanceRelationship',
    apiResourceName: 'trackedEntityInstanceRelationships')
class TrackedEntityInstanceRelationship extends BaseEntity {
  @ManyToOne(
      table: TrackedEntityInstance, joinColumnName: 'fromTrackedInstance')
  String fromTrackedInstance;

  @Column()
  String toTrackedInstance;

  @Column()
  String relationshipType;

  TrackedEntityInstanceRelationship(
      {String? id,
      String? created,
      String? lastUpdated,
      required this.fromTrackedInstance,
      required this.toTrackedInstance,
      required this.relationshipType,
      required bool dirty})
      : super(id: id, dirty: dirty, created: created, lastUpdated: lastUpdated);

  factory TrackedEntityInstanceRelationship.fromJson(
      Map<String, dynamic> json) {
    return TrackedEntityInstanceRelationship(
        id: json['id'],
        fromTrackedInstance: json['fromTrackedInstance'] ??
            json['from']?['trackedEntityInstance']?['trackedEntityInstance'],
        toTrackedInstance: json['toTrackedInstance'] ??
            json['to']?['trackedEntityInstance']?['trackedEntityInstance'],
        relationshipType: json['relationshipType'],
        created: json['created'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['fromTrackedInstance'] = this.fromTrackedInstance;
    data['toTrackedInstance'] = this.toTrackedInstance;
    data['relationshipType'] = this.relationshipType;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['dirty'] = this.dirty;

    return data;
  }

  static toUpload(
      TrackedEntityInstanceRelationship trackedEntityInstanceRelationship) {
    return {
      "relationshipType": trackedEntityInstanceRelationship.relationshipType,
      "relationship": trackedEntityInstanceRelationship.id,
      "from": {
        "trackedEntityInstance": {
          "trackedEntityInstance":
              trackedEntityInstanceRelationship.fromTrackedInstance,
        }
      },
      "to": {
        "trackedEntityInstance": {
          "trackedEntityInstance":
              trackedEntityInstanceRelationship.toTrackedInstance
        }
      }
    };
  }
}
