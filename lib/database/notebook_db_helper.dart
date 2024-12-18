import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes_app/database/databasehelper.dart';
import 'package:notes_app/home/modals/noteBook_modal.dart';
import 'package:sqflite/sqflite.dart';   // for join function for the path

class NotebookDbHelper {
  static final NotebookDbHelper instance = NotebookDbHelper._instance();
  static Database? _database;

  NotebookDbHelper._instance();

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
  //     CREATE TABLE Notebook_db (
  //       id INTEGER PRIMARY KEY,
  //       background TEXT,
  //       title TEXT
  //     )
  //   ''');
  // }

  Future<int> createNotebook(NotebookModal notebook) async {
    Database db = await instance.db;
    
    return await db.insert('Notebook_db', notebook.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllNotebooks() async {
    Database db = await instance.db;
    return await db.query('Notebook_db');
  }

  Future<int> updateNotebook(NotebookModal notebook) async {
    Database db = await instance.db;
    return await db.update('Notebook_db', notebook.toMap(), where: 'id = ?', whereArgs: [notebook.id]);
  }

  Future<int> deleteNotebook(int id) async {
    Database db = await instance.db;
    debugPrint("$id user deleted");
    return await db.delete('Notebook_db', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> initializeNoteBook() async {
    List<NotebookModal> notesToAdd = [
      NotebookModal(background: "none", title: "new Notebook"),
      NotebookModal(background: "null" , title: "All notes"),
    ];

    for (NotebookModal notebook in notesToAdd) {
      await createNotebook(notebook);
    }
  }
}
