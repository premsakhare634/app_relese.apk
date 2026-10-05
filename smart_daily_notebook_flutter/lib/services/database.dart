import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/entry.dart';

class DatabaseService {
  static final instance = DatabaseService._();
  DatabaseService._();
  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    final dir = await getDatabasesPath();
    _db = await openDatabase(join(dir,'smart_daily_notebook.db'), version: 1,
      onCreate: (db, v) async {
        await db.execute('CREATE TABLE entries (id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT NOT NULL, title TEXT NOT NULL, content TEXT NOT NULL, date TEXT NOT NULL, time TEXT, priority INTEGER NOT NULL DEFAULT 0, reminder_enabled INTEGER NOT NULL DEFAULT 0, completed INTEGER NOT NULL DEFAULT 0, created_at TEXT NOT NULL, updated_at TEXT NOT NULL, recurrence TEXT NOT NULL DEFAULT "")');
        await db.execute('CREATE INDEX idx_entries_date ON entries(date)');
      });
    return _db!;
  }

  Future<int> insert(Entry e) async => (await db).insert('entries', e.toMap());
  Future<void> update(Entry e) async => (await db).update('entries', e.toMap(), where:'id=?', whereArgs:[e.id]);
  Future<void> delete(int id) async => (await db).delete('entries', where:'id=?', whereArgs:[id]);

  Future<List<Entry>> all() async {
    final rows = await (await db).query('entries', orderBy:'date ASC, time ASC, id ASC');
    return rows.map(Entry.fromMap).toList();
  }

  Future<List<Entry>> forDate(DateTime d) async {
    final start=DateTime(d.year,d.month,d.day).toIso8601String();
    final end=DateTime(d.year,d.month,d.day+1).toIso8601String();
    final rows=await (await db).query('entries',where:'date>=? AND date<?',whereArgs:[start,end],orderBy:'time ASC,id ASC');
    return rows.map(Entry.fromMap).toList();
  }

  Future<List<Entry>> search(String q) async {
    final rows=await (await db).query('entries',where:'title LIKE ? OR content LIKE ?',whereArgs:['%$q%','%$q%'],orderBy:'date DESC,id DESC');
    return rows.map(Entry.fromMap).toList();
  }
}
