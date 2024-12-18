import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes_app/database/databasehelper.dart';
import 'package:notes_app/home/modals/notes_modal.dart';
import 'package:sqflite/sqflite.dart';   // for join function for the path

class NotesDbHelper {
  static final NotesDbHelper instance = NotesDbHelper._instance();
  static Database? _database;

  NotesDbHelper._instance();

  Future<Database> get db async {
      _database ??= await DatabaseHelper.instance.initDb();
    return _database!;
  }

  // Future<Database> initDb() async {
  //   String databasesPath = await getDatabasesPath();
  //   String path = join(databasesPath, 'NotesApp.db');
//
  //   return await openDatabase(path, version: 2, onCreate: _onCreate);
  // }
//
  // Future _onCreate(Database db, int version) async {
  //   await db.execute('''
  //     CREATE TABLE Notes_db (
  //       id INTEGER PRIMARY KEY,
  //       creationTime TEXT,
  //       content TEXT
  //     )
  //   ''');
  // }

  Future<int> insertNote(NotesModal note) async {
    Database db = await instance.db;
    
    return await db.insert('Notes_db', note.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllNotes() async {
    Database db = await instance.db;
    return await db.query('Notes_db');
  }

  Future<int> updateNotes(NotesModal note) async {
    Database db = await instance.db;
    return await db.update('Notes_db', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> deleteNotes(int id) async {
    Database db = await instance.db;
    debugPrint("$id user deleted");
    return await db.delete('Notes_db', where: 'id = ?', whereArgs: [id]);
  }

}
