import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes_app/database/databasehelper.dart';
import 'package:notes_app/todo_home.dart/modal/todo_modal.dart';
import 'package:sqflite/sqflite.dart';   // for join function for the path

class TodoDbHelper {
  static final TodoDbHelper instance = TodoDbHelper._instance();
  static Database? _database;

  TodoDbHelper._instance();

  Future<Database> get db async {
      _database ??= await DatabaseHelper.instance.initDb();
    return _database!;
  }

  Future<int> insertTodo(TodoModal todo) async {
    Database db = await instance.db;
    
    return await db.insert('todo_db', todo.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllTodo() async {
    Database db = await instance.db;
    return await db.query('todo_db');
  }

  Future<int> updateTodo(TodoModal todo) async {
    Database db = await instance.db;
    return await db.update('todo_db', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<int> deleteTodo(int id) async {
    Database db = await instance.db;
    debugPrint("$id user deleted");
    return await db.delete('todo_db', where: 'id = ?', whereArgs: [id]);
  }

}
