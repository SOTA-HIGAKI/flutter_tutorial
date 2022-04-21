import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class LocalDB {
  static LocalDB? _localDB;
  static Database? _db;
  Database get instance => _db!; // getter

  // factory method for factory pattern ①
  factory LocalDB() =>
      _localDB ??= LocalDB._(); // if localDB is nil, apply right (singleton)

  // ② calling this constructor in factory method
  LocalDB._();

  static Future<void> init() async {
    final path = p.join(await getDatabasesPath(), 'local.db');
    deleteDatabase(path);
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute(_LocalDBTables.contents);
  }
}

abstract class _LocalDBTables {
  static const contents = '''
  CREATE TABLE contents (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id TEXT,
    text TEXT,
  )
  ''';
}
