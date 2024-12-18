
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
    static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'NotesApp.db');

    return await openDatabase(path, version: 3, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Notes_db (
        id INTEGER PRIMARY KEY,
        creationTime TEXT,
        notebookName TEXT,
        content TEXT
      )
    ''');

      await db.execute('''
      CREATE TABLE Notebook_db (
        id INTEGER PRIMARY KEY,
        background TEXT,
        title TEXT
      )
    ''');

      await db.execute('''
      CREATE TABLE todo_db (
        id INTEGER PRIMARY KEY,
        content TEXT,
        done TEXT
      )
    ''');

       await db.execute('''
      CREATE TABLE art_db (
        id INTEGER PRIMARY KEY,
        artPath TEXT,
        artName TEXT
      )
    ''');
  }
}