import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseUtil {
  /**
   * Get database name form shared preferences
   */
  static Future<String?> getDatabaseName(
      {Future<SharedPreferences>? sharedPreferenceInstance}) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs =
        await (sharedPreferenceInstance ?? SharedPreferences.getInstance());
    return prefs.getString('databaseName');
  }

/**
 * Set database name into the shared preferences
 */
  static Future<bool> setDatabaseName(
      {required String databaseName,
      required SharedPreferences sharedPreferenceInstance}) async {
    return sharedPreferenceInstance.setString('databaseName', databaseName);
  }

  static Future<void> removeDatabaseName(
      {Future<SharedPreferences>? sharedPreferenceInstance}) async {
    SharedPreferences prefs =
        await (sharedPreferenceInstance ?? SharedPreferences.getInstance());
    await prefs.remove('databaseName');
  }
}
