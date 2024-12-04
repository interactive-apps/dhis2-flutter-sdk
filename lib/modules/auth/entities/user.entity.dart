import 'dart:convert';

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/auth/entities/user_authority.entity.dart';
import 'package:d2_touch/modules/auth/entities/user_group.entity.dart';
import 'package:d2_touch/modules/auth/entities/user_group_user.entity.dart';
import 'package:d2_touch/modules/auth/entities/user_organisation_unit.entity.dart';
import 'package:d2_touch/modules/auth/entities/user_role.entity.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';

@AnnotationReflectable
@Entity(tableName: 'user', apiResourceName: 'users')
class User extends IdentifiableEntity {
  @Column(nullable: true)
  final String? username;

  @Column(nullable: true)
  final String? password;

  @Column()
  final String firstName;

  @Column(nullable: true)
  final String? surname;

  @Column(nullable: true)
  final String? phoneNumber;

  @Column(nullable: true)
  final String? token;

  @Column(nullable: true)
  final String? tokenType;

  @Column(nullable: true)
  final String? refreshToken;

  @Column(nullable: true)
  final String? tokenExpiresAt;

  @Column(nullable: true)
  final int? tokenExpiry;

  @Column(nullable: true)
  final String? authType;

  @Column()
  final String baseUrl;

  @Column(nullable: true)
  final String? teiSearchOrganisationUnits;

  @OneToMany(table: UserOrganisationUnit)
  List<UserOrganisationUnit>? organisationUnits;

  @OneToMany(table: UserAuthority)
  List<UserAuthority>? authorities;

  @OneToMany(table: UserRole)
  List<UserRole>? roles;

  @Column(nullable: true)
  final dynamic dataViewOrganisationUnits;

  @Column(nullable: true)
  final String? programs;

  @Column(nullable: true)
  final String? dataSets;

  @Column()
  bool isLoggedIn;

  @Column(nullable: true)
  final String? gender;

  @Column()
  String? jobTitle;

  @OneToMany(table: UserGroupUser)
  List<UserGroup>? userGroups;

  User(
      {required String id,
      this.username,
      this.password,
      required this.firstName,
      required this.surname,
      required String name,
      required this.baseUrl,
      this.gender,
      this.jobTitle,
      String? shortName,
      String? displayName,
      String? code,
      String? created,
      String? lastUpdated,
      this.teiSearchOrganisationUnits,
      this.organisationUnits,
      this.authorities,
      this.roles,
      this.dataViewOrganisationUnits,
      this.programs,
      this.dataSets,
      this.token,
      this.tokenType,
      this.refreshToken,
      this.tokenExpiry,
      this.authType,
      this.phoneNumber,
      this.userGroups,
      this.tokenExpiresAt,
      required this.isLoggedIn,
      required bool dirty})
      : super(
            id: id,
            name: name,
            dirty: dirty,
            created: created,
            lastUpdated: lastUpdated);

  factory User.fromJson(Map<String, dynamic> jsonData) {
    return User(
        id: jsonData['id'],
        gender: jsonData['gender'] ?? '',
        jobTitle: jsonData['jobTitle'] ?? '',
        username: jsonData['username'],
        password: jsonData['password'],
        firstName: jsonData['firstName'],
        surname: jsonData['surname'],
        token: jsonData['token'],
        tokenType: jsonData['tokenType'],
        refreshToken: jsonData['refreshToken'],
        tokenExpiry: jsonData['tokenExpiry'],
        authType: jsonData['authType'],
        name: jsonData['name'],
        phoneNumber: jsonData['phoneNumber'],
        baseUrl: jsonData['baseUrl'] ?? '',
        created: jsonData['created'],
        lastUpdated: jsonData['lastUpdated'],
        teiSearchOrganisationUnits:
            jsonData['teiSearchOrganisationUnits'].toString(),
        organisationUnits: (jsonData['organisationUnits'] ?? [])
            .map<UserOrganisationUnit>(
                (ou) => UserOrganisationUnit.fromJson(ou))
            .toList() as List<UserOrganisationUnit>,
        authorities: (jsonData['authorities'] ?? [])
            .map<UserAuthority>((authority) => UserAuthority(
                id: authority['id'],
                name: authority['name'],
                authority: authority['authority'],
                user: authority['user'],
                dirty: authority['dirty'] ?? false))
            .toList(),
        roles: (jsonData['roles'] ?? [])
            .map<UserRole>((role) => UserRole(
                id: role['id'],
                name: role['name'],
                user: role['user'],
                dirty: role['dirty'] ?? false))
            .toList(),
        dataViewOrganisationUnits:
            jsonEncode(jsonData['dataViewOrganisationUnits']),
        programs: jsonData['programs'].toString(),
        dataSets: jsonData['datasets'].toString(),
        isLoggedIn: jsonData['isLoggedIn'] ?? false,
        userGroups: (jsonData['userGroups'] ?? [])
            .map<UserGroup>((group) => UserGroup.fromJson(group))
            .toList(),
        tokenExpiresAt: jsonData['tokenExpiresAt'] ??
            DateTime.now()
                .add(Duration(seconds: jsonData['tokenExpiry'] ?? 3600))
                .toIso8601String(),
        dirty: jsonData['dirty']);
  }

  factory User.fromApi(Map<String, dynamic> jsonData) {
    return User(
        id: jsonData['id'],
        gender: jsonData['gender'] ?? '',
        jobTitle: jsonData['jobTitle'] ?? '',
        username: jsonData['username'],
        password: jsonData['password'],
        firstName: jsonData['firstName'],
        surname: jsonData['surname'],
        name: jsonData['name'],
        phoneNumber: jsonData['phoneNumber'],
        baseUrl: jsonData['baseUrl'] ?? '',
        created: jsonData['created'],
        lastUpdated: jsonData['lastUpdated'],
        token: jsonData['token'],
        tokenType: jsonData['tokenType'],
        refreshToken: jsonData['refreshToken'],
        tokenExpiry: jsonData['tokenExpiry'],
        authType: jsonData['authType'],
        teiSearchOrganisationUnits:
            jsonData['teiSearchOrganisationUnits'].toString(),
        organisationUnits: jsonData['organisationUnits']
            .map<UserOrganisationUnit>((orgUnit) => UserOrganisationUnit(
                id: '${jsonData['id']}_${orgUnit['id']}',
                name: '${jsonData['id']}_${orgUnit['id']}',
                orgUnit: orgUnit['id'],
                parent:
                    orgUnit['parent'] != null ? orgUnit['parent']['id'] : null,
                user: jsonData['id'],
                type: 'DATA_VIEW',
                dirty: jsonData['dirty'] ?? false))
            .toList(),
        authorities: getAuthorities(jsonData),
        roles: (jsonData['userCredentials']?['userRoles'] ?? [])
            .map<UserRole>((role) => UserRole(
                id: '${jsonData['id']}_${role['id']}',
                name: role['name'],
                user: jsonData['id'],
                dirty: jsonData['dirty'] ?? true))
            .toList(),
        dataViewOrganisationUnits:
            jsonEncode(jsonData['dataViewOrganisationUnits']),
        programs: jsonData['programs'] != null
            ? jsonData['programs'].toString()
            : null,
        dataSets: jsonData['datasets'] != null
            ? jsonData['datasets'].toString()
            : null,
        isLoggedIn: jsonData['isLoggedIn'] ?? false,
        tokenExpiresAt: jsonData['tokenExpiresAt'] ??
            DateTime.now()
                .add(Duration(seconds: jsonData['tokenExpiry'] ?? 3600))
                .toIso8601String(),
        dirty: jsonData['dirty'] ?? false);
  }

  static List<UserAuthority> getAuthorities(Map<String, dynamic> jsonData) {
    List<UserAuthority> authorities = (jsonData['authorities'] ?? [])
        .map<UserAuthority>((authority) => UserAuthority(
            id: '${jsonData['id']}_$authority',
            name: '${jsonData['id']}_$authority',
            authority: authority,
            user: jsonData['id'],
            dirty: jsonData['dirty'] ?? false))
        .toList();

    if (jsonData['userCredentials']?['userRoles'] != null) {
      for (Map<String, dynamic> role in jsonData['userCredentials']
          ?['userRoles']) {
        List<UserAuthority> roleAuthorities = (role['authorities'] ?? [])
            .map<UserAuthority>((authority) => UserAuthority(
                id: '${jsonData['id']}_$authority',
                name: '${jsonData['id']}_$authority',
                authority: authority,
                user: jsonData['id'],
                dirty: jsonData['dirty'] ?? false))
            .toList();
        authorities = [...authorities, ...roleAuthorities];
      }
    }

    return authorities;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['gender'] = this.gender;
    data['jobTitle'] = this.jobTitle;
    data['name'] = this.name;
    data['firstName'] = this.firstName;
    data['surname'] = this.surname;
    data['username'] = this.username;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['created'] = this.created;
    data['lastUpdated'] = this.lastUpdated;
    data['token'] = this.token;
    data['tokenType'] = this.tokenType;
    data['refreshToken'] = this.refreshToken;
    data['phoneNumber'] = this.phoneNumber;
    data['tokenExpiry'] = this.tokenExpiry;
    data['authType'] = this.authType;
    data['teiSearchOrganisationUnits'] = this.teiSearchOrganisationUnits;
    data['organisationUnits'] = this.organisationUnits;
    data['authorities'] = this.authorities;
    data['roles'] = this.roles;
    data['dataViewOrganisationUnits'] = this.dataViewOrganisationUnits;
    data['programs'] = this.programs;
    data['isLoggedIn'] = this.isLoggedIn;
    data['baseUrl'] = this.baseUrl;
    data['dirty'] = this.dirty;
    data['userGroups'] = this.userGroups;
    data['tokenExpiresAt'] = this.tokenExpiresAt;

    return data;
  }
}
