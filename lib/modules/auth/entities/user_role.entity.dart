import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

import 'user.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'userRoles', apiResourceName: 'userRoles')
class UserRole extends IdentifiableEntity {
  @ManyToOne(joinColumnName: 'user', table: User)
  dynamic user;

  UserRole(
      {required String id,
      required String name,
      required this.user,
      required bool dirty})
      : super(id: id, name: name, dirty: dirty);

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
        id: json['id'],
        name: json['id'],
        user: json['user'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user'] = this.user;
    data['dirty'] = this.dirty;
    return data;
  }
}
