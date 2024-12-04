import 'package:async/async.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  final int version = 1;
  String databaseName = 'flutter_database.db';
  bool inMemory = false;
  DatabaseFactory? databaseFactory;

  static DatabaseManager? _databaseInstance;

  static Database? _database;
  final _initDatabaseMemoizer = AsyncMemoizer<Database>();

  factory DatabaseManager(
      {String? databaseName,
      bool? inMemory,
      DatabaseFactory? databaseFactory}) {
    if (_databaseInstance == null) {
      _databaseInstance = new DatabaseManager._internal();
      if (databaseName != null) {
        _databaseInstance?.databaseName = databaseName;
      }

      if (inMemory != null) {
        _databaseInstance?.inMemory = inMemory;
      }

      _databaseInstance?.databaseFactory = databaseFactory;
    }

    return _databaseInstance as DatabaseManager;
  }

  DatabaseManager._internal();

  static DatabaseManager? get instance => _databaseInstance;

  Future<Database> get database async {
    if (_database != null) {
      return _database as Database;
    }

    return await _initDatabaseMemoizer.runOnce(() async {
      return await initializeDatabase();
    });
  }

  initializeDatabase() async {
    if (databaseFactory != null) {
      bool databaseExist = await databaseFactory!.databaseExists(databaseName);

      if (databaseExist) {
        await databaseFactory?.deleteDatabase(databaseName);
      }
      return databaseFactory?.openDatabase(databaseName,
          options: OpenDatabaseOptions(onConfigure: _onConfigure));
    }

    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, databaseName + '.db');

    var database = inMemory
        ? await openDatabase(inMemoryDatabasePath, onConfigure: _onConfigure)
        : await openDatabase(path,
            version: version,
            onCreate: _createDatabase,
            onConfigure: _onConfigure);
    return database;
  }

  _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = OFF");
  }

  closeDatabase() async {
    await _database?.close();
  }

  dispose() async {
    await _database?.close();
    await databaseFactory?.deleteDatabase(databaseName);
    _databaseInstance = null;
  }

  void _createDatabase(Database database, int version) async {}
}
