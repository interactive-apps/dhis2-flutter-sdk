import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

import 'user.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'userAuthority', apiResourceName: 'userAuthorities')
class UserAuthority extends IdentifiableEntity {
  @Column()
  final String authority;

  @ManyToOne(joinColumnName: 'user', table: User)
  dynamic user;

  UserAuthority(
      {required String id,
      required String name,
      required this.authority,
      required this.user,
      required bool dirty})
      : super(id: id, name: name, dirty: dirty);

  factory UserAuthority.fromJson(Map<String, dynamic> json) {
    return UserAuthority(
        id: json['id'],
        name: json['id'],
        authority: json['authority'],
        user: json['user'],
        dirty: json['dirty']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['authority'] = this.authority;
    data['user'] = this.user;
    data['dirty'] = this.dirty;
    return data;
  }
}
