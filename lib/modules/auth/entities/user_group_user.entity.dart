import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/auth/entities/user_group.entity.dart';
import 'package:d2_touch/shared/entities/base.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'userGroupUser', apiResourceName: 'userGroups')
class UserGroupUser extends BaseEntity {
  @ManyToOne(table: User, joinColumnName: 'userId')
  String userId;

  @ManyToOne(table: UserGroup, joinColumnName: 'groupId')
  String groupId;

  UserGroupUser(
      {String? id,
      String? lastUpdated,
      String? created,
      required this.userId,
      required this.groupId,
      required bool dirty})
      : super(
          id: id,
          dirty: dirty,
          lastUpdated: lastUpdated,
          created: created,
        );

  factory UserGroupUser.fromJson(Map<String, dynamic> json) {
    return UserGroupUser(
      id: json['id'],
      userId: json['userId'],
      groupId: json['groupId'],
      dirty: json['dirty'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['userId'] = this.userId;
    data['groupId'] = this.groupId;
    data['dirty'] = this.dirty;
    return data;
  }
}
