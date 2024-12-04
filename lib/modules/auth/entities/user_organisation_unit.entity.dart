import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

import 'user.entity.dart';

@AnnotationReflectable
@Entity(
    tableName: 'userOrganisationUnit', apiResourceName: 'userOrganisationUnits')
class UserOrganisationUnit extends IdentifiableEntity {
  @Column()
  final String orgUnit;

  @Column(nullable: true)
  final String? parent;

  @Column(nullable: true)
  final String? type;

  @ManyToOne(joinColumnName: 'user', table: User)
  dynamic user;

  UserOrganisationUnit(
      {required String id,
      required String name,
      required this.orgUnit,
      this.parent,
      required this.user,
      this.type,
      required bool dirty})
      : super(id: id, name: name, dirty: dirty);

  factory UserOrganisationUnit.fromJson(Map<String, dynamic> json) {
    return UserOrganisationUnit(
        id: json['id'],
        name: json['id'],
        orgUnit: json['orgUnit'] ?? json['id'],
        parent: json['parent'] != null && json['parent'].runtimeType == List
            ? json['parent']['id']
            : json['parent'].runtimeType == String
                ? json['parent']
                : null,
        user: json['user'],
        type: json['type'],
        dirty: json['dirty'].runtimeType == "String"
            ? json["dirty"] == "true"
                ? true
                : false
            : json['dirty'] ?? false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['orgUnit'] = this.orgUnit;
    data['parent'] = this.parent;
    data['type'] = this.type;
    data['user'] = this.user;
    data['dirty'] = this.dirty;
    return data;
  }
}
