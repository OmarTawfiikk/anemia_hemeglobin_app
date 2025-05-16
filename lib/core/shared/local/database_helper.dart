import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = 'AnemiaApp.db';

  // Changed from private _getDB() to public getDB()
  static Future<Database> getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE User (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            phone TEXT NOT NULL,
            password TEXT NOT NULL,
            dateOfBirth TEXT NOT NULL,
            isVerified INTEGER DEFAULT 0,
            token TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE TestHistory (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId INTEGER NOT NULL,
            testType TEXT NOT NULL,
            result TEXT NOT NULL,
            date TEXT NOT NULL,
            imagePath TEXT,
            FOREIGN KEY (userId) REFERENCES User (id)
          );
        ''');
      },
      version: _version,
    );
  }

  static Future<int> addUser(Map<String, dynamic> user) async {
    final db = await getDB();
    return await db.insert('User', user,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await getDB();
    final result = await db.query(
      'User',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  static Future<int> addTestHistory(Map<String, dynamic> history) async {
    final db = await getDB();
    return await db.insert('TestHistory', history);
  }

  static Future<List<Map<String, dynamic>>> getTestHistory(int userId) async {
    final db = await getDB();
    return await db.query(
      'TestHistory',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
    );
  }

  static Future<int> deleteTestHistory(int id) async {
    final db = await getDB();
    return await db.delete(
      'TestHistory',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Added new method to verify user
  static Future<int> verifyUser(String email) async {
    final db = await getDB();
    return await db.update(
      'User',
      {'isVerified': 1},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  // Added new method to get all users (for admin purposes)
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await getDB();
    return await db.query('User');
  }
}