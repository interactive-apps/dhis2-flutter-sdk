import 'package:d2_touch/modules/auth/entities/user_authority.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class UserAuthorityQuery extends BaseQuery<UserAuthority> {
  UserAuthorityQuery({Database? database}) : super(database: database);
}
