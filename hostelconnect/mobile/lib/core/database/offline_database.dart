import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';

class OfflineDatabase {
  static Database? _database;
  static const String _databaseName = 'hostelconnect_offline.db';
  static const int _databaseVersion = 1;

  // Table names
  static const String tableUsers = 'users';
  static const String tableStudents = 'students';
  static const String tableHostels = 'hostels';
  static const String tableRooms = 'rooms';
  static const String tableGatePasses = 'gatepasses';
  static const String tableAttendance = 'attendance';
  static const String tableMeals = 'meals';
  static const String tableNotices = 'notices';
  static const String tableSyncQueue = 'sync_queue';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE $tableUsers (
        id TEXT PRIMARY KEY,
        email TEXT UNIQUE NOT NULL,
        firstName TEXT,
        lastName TEXT,
        role TEXT NOT NULL,
        hostelId TEXT,
        roomId TEXT,
        isActive INTEGER DEFAULT 1,
        lastSyncAt TEXT,
        isDirty INTEGER DEFAULT 0,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    // Students table
    await db.execute('''
      CREATE TABLE $tableStudents (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        studentId TEXT UNIQUE NOT NULL,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        phone TEXT,
        hostelId TEXT NOT NULL,
        roomId TEXT,
        bedNumber INTEGER,
        role TEXT DEFAULT 'STUDENT',
        isActive INTEGER DEFAULT 1,
        lastSyncAt TEXT,
        isDirty INTEGER DEFAULT 0,
        createdAt TEXT,
        updatedAt TEXT,
        FOREIGN KEY (userId) REFERENCES $tableUsers (id)
      )
    ''');

    // Hostels table
    await db.execute('''
      CREATE TABLE $tableHostels (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        address TEXT,
        capacity INTEGER NOT NULL,
        isActive INTEGER DEFAULT 1,
        lastSyncAt TEXT,
        isDirty INTEGER DEFAULT 0,
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    // Rooms table
    await db.execute('''
      CREATE TABLE $tableRooms (
        id TEXT PRIMARY KEY,
        hostelId TEXT NOT NULL,
        blockId TEXT,
        roomNumber TEXT NOT NULL,
        floor INTEGER,
        capacity INTEGER NOT NULL,
        currentOccupancy INTEGER DEFAULT 0,
        isActive INTEGER DEFAULT 1,
        lastSyncAt TEXT,
        isDirty INTEGER DEFAULT 0,
        createdAt TEXT,
        updatedAt TEXT,
        FOREIGN KEY (hostelId) REFERENCES $tableHostels (id)
      )
    ''');

    // Gate Passes table
    await db.execute('''
      CREATE TABLE $tableGatePasses (
        id TEXT PRIMARY KEY,
        studentId TEXT NOT NULL,
        reason TEXT NOT NULL,
        destination TEXT,
        departureTime TEXT,
        expectedReturnTime TEXT,
        status TEXT DEFAULT 'PENDING',
        approvedBy TEXT,
        approvedAt TEXT,
        createdAt TEXT,
        updatedAt TEXT,
        lastSyncAt TEXT,
        isDirty INTEGER DEFAULT 0,
        FOREIGN KEY (studentId) REFERENCES $tableStudents (id)
      )
    ''');

    // Attendance table
    await db.execute('''
      CREATE TABLE $tableAttendance (
        id TEXT PRIMARY KEY,
        studentId TEXT NOT NULL,
        scanTime TEXT NOT NULL,
        location TEXT,
        qrToken TEXT,
        isPresent INTEGER DEFAULT 1,
        createdAt TEXT,
        lastSyncAt TEXT,
        isDirty INTEGER DEFAULT 0,
        FOREIGN KEY (studentId) REFERENCES $tableStudents (id)
      )
    ''');

    // Meals table
    await db.execute('''
      CREATE TABLE $tableMeals (
        id TEXT PRIMARY KEY,
        studentId TEXT NOT NULL,
        mealType TEXT NOT NULL,
        date TEXT NOT NULL,
        intent INTEGER DEFAULT 0,
        createdAt TEXT,
        updatedAt TEXT,
        lastSyncAt TEXT,
        isDirty INTEGER DEFAULT 0,
        FOREIGN KEY (studentId) REFERENCES $tableStudents (id)
      )
    ''');

    // Notices table
    await db.execute('''
      CREATE TABLE $tableNotices (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        type TEXT DEFAULT 'general',
        priority TEXT DEFAULT 'medium',
        targetRole TEXT,
        targetUserId TEXT,
        isRead INTEGER DEFAULT 0,
        readAt TEXT,
        expiresAt TEXT,
        createdAt TEXT,
        lastSyncAt TEXT,
        isDirty INTEGER DEFAULT 0
      )
    ''');

    // Sync Queue table
    await db.execute('''
      CREATE TABLE $tableSyncQueue (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tableName TEXT NOT NULL,
        recordId TEXT NOT NULL,
        action TEXT NOT NULL,
        data TEXT NOT NULL,
        priority INTEGER DEFAULT 0,
        retryCount INTEGER DEFAULT 0,
        maxRetries INTEGER DEFAULT 3,
        status TEXT DEFAULT 'pending',
        createdAt TEXT,
        updatedAt TEXT
      )
    ''');

    // Create indexes
    await db.execute('CREATE INDEX idx_users_email ON $tableUsers (email)');
    await db.execute('CREATE INDEX idx_students_studentId ON $tableStudents (studentId)');
    await db.execute('CREATE INDEX idx_gatepasses_studentId ON $tableGatePasses (studentId)');
    await db.execute('CREATE INDEX idx_attendance_studentId ON $tableAttendance (studentId)');
    await db.execute('CREATE INDEX idx_meals_studentId ON $tableMeals (studentId)');
    await db.execute('CREATE INDEX idx_sync_queue_status ON $tableSyncQueue (status)');
  }

  static Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades here
    if (oldVersion < 2) {
      // Add new columns or tables for version 2
    }
  }

  // Generic CRUD operations
  static Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    data['lastSyncAt'] = DateTime.now().toIso8601String();
    data['isDirty'] = 1;
    return await db.insert(table, data);
  }

  static Future<int> update(String table, Map<String, dynamic> data, String where, List<dynamic> whereArgs) async {
    final db = await database;
    data['lastSyncAt'] = DateTime.now().toIso8601String();
    data['isDirty'] = 1;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  static Future<int> delete(String table, String where, List<dynamic> whereArgs) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  static Future<List<Map<String, dynamic>>> query(String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    final db = await database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  // Sync operations
  static Future<void> addToSyncQueue(String tableName, String recordId, String action, Map<String, dynamic> data) async {
    final db = await database;
    await db.insert(tableSyncQueue, {
      'tableName': tableName,
      'recordId': recordId,
      'action': action,
      'data': jsonEncode(data),
      'priority': _getActionPriority(action),
      'status': 'pending',
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  static int _getActionPriority(String action) {
    switch (action.toLowerCase()) {
      case 'create':
        return 1;
      case 'update':
        return 2;
      case 'delete':
        return 3;
      default:
        return 0;
    }
  }

  static Future<List<Map<String, dynamic>>> getSyncQueue({int? limit}) async {
    final db = await database;
    return await db.query(
      tableSyncQueue,
      where: 'status = ?',
      whereArgs: ['pending'],
      orderBy: 'priority ASC, createdAt ASC',
      limit: limit,
    );
  }

  static Future<void> markSyncItemCompleted(int id) async {
    final db = await database;
    await db.update(
      tableSyncQueue,
      {'status': 'completed', 'updatedAt': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> markSyncItemFailed(int id, String error) async {
    final db = await database;
    await db.update(
      tableSyncQueue,
      {
        'status': 'failed',
        'retryCount': 'retryCount + 1',
        'updatedAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Data synchronization methods
  static Future<void> syncFromServer(Map<String, dynamic> serverData) async {
    final db = await database;
    
    await db.transaction((txn) async {
      // Sync users
      if (serverData['users'] != null) {
        for (var userData in serverData['users']) {
          await txn.insert(
            tableUsers,
            {...userData, 'isDirty': 0, 'lastSyncAt': DateTime.now().toIso8601String()},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      // Sync students
      if (serverData['students'] != null) {
        for (var studentData in serverData['students']) {
          await txn.insert(
            tableStudents,
            {...studentData, 'isDirty': 0, 'lastSyncAt': DateTime.now().toIso8601String()},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      // Sync hostels
      if (serverData['hostels'] != null) {
        for (var hostelData in serverData['hostels']) {
          await txn.insert(
            tableHostels,
            {...hostelData, 'isDirty': 0, 'lastSyncAt': DateTime.now().toIso8601String()},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      // Sync rooms
      if (serverData['rooms'] != null) {
        for (var roomData in serverData['rooms']) {
          await txn.insert(
            tableRooms,
            {...roomData, 'isDirty': 0, 'lastSyncAt': DateTime.now().toIso8601String()},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      // Sync gate passes
      if (serverData['gatePasses'] != null) {
        for (var gatePassData in serverData['gatePasses']) {
          await txn.insert(
            tableGatePasses,
            {...gatePassData, 'isDirty': 0, 'lastSyncAt': DateTime.now().toIso8601String()},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      // Sync attendance
      if (serverData['attendance'] != null) {
        for (var attendanceData in serverData['attendance']) {
          await txn.insert(
            tableAttendance,
            {...attendanceData, 'isDirty': 0, 'lastSyncAt': DateTime.now().toIso8601String()},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      // Sync meals
      if (serverData['meals'] != null) {
        for (var mealData in serverData['meals']) {
          await txn.insert(
            tableMeals,
            {...mealData, 'isDirty': 0, 'lastSyncAt': DateTime.now().toIso8601String()},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      // Sync notices
      if (serverData['notices'] != null) {
        for (var noticeData in serverData['notices']) {
          await txn.insert(
            tableNotices,
            {...noticeData, 'isDirty': 0, 'lastSyncAt': DateTime.now().toIso8601String()},
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }
    });
  }

  static Future<List<Map<String, dynamic>>> getDirtyRecords(String tableName) async {
    final db = await database;
    return await db.query(
      tableName,
      where: 'isDirty = ?',
      whereArgs: [1],
      orderBy: 'updatedAt ASC',
    );
  }

  static Future<void> markRecordsAsSynced(String tableName, List<String> recordIds) async {
    final db = await database;
    await db.update(
      tableName,
      {'isDirty': 0, 'lastSyncAt': DateTime.now().toIso8601String()},
      where: 'id IN (${recordIds.map((_) => '?').join(',')})',
      whereArgs: recordIds,
    );
  }

  // Utility methods
  static Future<void> clearAllData() async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.delete(tableUsers);
      await txn.delete(tableStudents);
      await txn.delete(tableHostels);
      await txn.delete(tableRooms);
      await txn.delete(tableGatePasses);
      await txn.delete(tableAttendance);
      await txn.delete(tableMeals);
      await txn.delete(tableNotices);
      await txn.delete(tableSyncQueue);
    });
  }

  static Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  // Get database size
  static Future<int> getDatabaseSize() async {
    final db = await database;
    final result = await db.rawQuery('SELECT page_count * page_size as size FROM pragma_page_count(), pragma_page_size()');
    return result.first['size'] as int;
  }

  // Get record counts
  static Future<Map<String, int>> getRecordCounts() async {
    final db = await database;
    final tables = [tableUsers, tableStudents, tableHostels, tableRooms, tableGatePasses, tableAttendance, tableMeals, tableNotices];
    final counts = <String, int>{};

    for (final table in tables) {
      final result = await db.rawQuery('SELECT COUNT(*) as count FROM $table');
      counts[table] = result.first['count'] as int;
    }

    return counts;
  }
}
