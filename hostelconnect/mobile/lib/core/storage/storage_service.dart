// Storage utilities for local data persistence
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class StorageService {
  static Database? _database;
  static SharedPreferences? _prefs;

  // Initialize storage
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _database = await _initDatabase();
  }

  // Database initialization
  static Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'hostelconnect.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create tables for offline storage
        await db.execute('''
          CREATE TABLE offline_events (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT NOT NULL,
            data TEXT NOT NULL,
            timestamp INTEGER NOT NULL,
            synced INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }

  // SharedPreferences methods
  static Future<bool> setString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // Database methods for offline events
  static Future<int> insertOfflineEvent(String type, String data) async {
    return await _database?.insert('offline_events', {
      'type': type,
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'synced': 0,
    }) ?? 0;
  }

  static Future<List<Map<String, dynamic>>> getUnsyncedEvents() async {
    return await _database?.query(
      'offline_events',
      where: 'synced = ?',
      whereArgs: [0],
      orderBy: 'timestamp ASC',
    ) ?? [];
  }

  static Future<void> markEventSynced(int id) async {
    await _database?.update(
      'offline_events',
      {'synced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
