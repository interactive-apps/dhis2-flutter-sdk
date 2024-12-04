import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/auth/entities/user_group_user.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'userGroup', apiResourceName: 'userGroups')
class UserGroup extends IdentifiableEntity {
  @OneToMany(table: UserGroupUser)
  List<UserGroupUser>? userGroupUsers;

  UserGroup(
      {String? id,
      required name,
      this.userGroupUsers,
      required String code,
      required bool dirty})
      : super(id: id, dirty: dirty, code: code, name: name);

  factory UserGroup.fromJson(Map<String, dynamic> json) {
    return UserGroup(
      id: json['id'],
      code: json['code'] ?? '',
      name: json['name'],
      userGroupUsers: json['userGroupUsers'],
      dirty: json['dirty'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['dirty'] = this.dirty;
    data['userGroupUsers'] = this.userGroupUsers;
    return data;
  }
}
