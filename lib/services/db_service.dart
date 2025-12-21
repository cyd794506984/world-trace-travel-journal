import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DbService {
  DbService._private();
  static final DbService instance = DbService._private();
  Database? _db;

  Future<Database> init() async {
    if (_db != null) return _db!;
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'worldtrace.db');
    _db = await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return _db!;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE trips (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT,
        countryIsoCode TEXT,
        startDate TEXT,
        endDate TEXT,
        tripType TEXT,
        title TEXT,
        notes TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE trip_steps (
        id TEXT PRIMARY KEY,
        tripId TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        latitude REAL NULL,
        longitude REAL NULL,
        placeName TEXT NULL,
        text TEXT NOT NULL,
        mediaPaths TEXT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE memories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tripId INTEGER,
        type TEXT,
        path TEXT,
        caption TEXT,
        createdAt TEXT
      )
    ''');

    await _createGoalsTable(db);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('DROP TABLE IF EXISTS goals');
      await _createGoalsTable(db);
    }
  }

  Future<void> _createGoalsTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS goals (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        title TEXT NOT NULL,
        type TEXT NOT NULL,
        targetValue INTEGER NOT NULL,
        year INTEGER NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await init();
    return db.insert(table, values);
  }

  Future<List<Map<String, dynamic>>> query(String table, {String? where, List<Object?>? whereArgs, String? orderBy}) async {
    final db = await init();
    return db.query(table, where: where, whereArgs: whereArgs, orderBy: orderBy);
  }

  Future<int> update(String table, Map<String, dynamic> values, String where, List<Object?> whereArgs) async {
    final db = await init();
    return db.update(table, values, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(String table, String where, List<Object?> whereArgs) async {
    final db = await init();
    return db.delete(table, where: where, whereArgs: whereArgs);
  }

  Future<void> deleteStepsForTrip(String tripId) async {
    final db = await init();
    await db.delete('trip_steps', where: 'tripId = ?', whereArgs: [tripId]);
  }

  Future<void> deleteTrip(String tripId) async {
    final db = await init();
    final idArg = int.tryParse(tripId);
    await db.delete('trips', where: 'id = ?', whereArgs: [idArg ?? tripId]);
  }
}
