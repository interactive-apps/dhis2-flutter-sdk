import 'package:sqflite/sqflite.dart';

class RawQueryModule {
  Database database;
  RawQueryModule({required this.database});
Future<List<Map>> execute(
      {required String query, required List args}) async {
            final List<Map> queryResult = await database.rawQuery(query.toString(), args);
    return queryResult;
  }
}
