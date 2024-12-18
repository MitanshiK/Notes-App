import 'dart:async';
import 'package:flutter/material.dart';
import 'package:notes_app/database/databasehelper.dart';
import 'package:notes_app/drawing_view/model/art_model.dart';
import 'package:sqflite/sqflite.dart';   // for join function for the path

class ArtDbHelper {
  static final ArtDbHelper instance = ArtDbHelper._instance();
  static Database? _database;

  ArtDbHelper._instance();

  Future<Database> get db async {
      _database ??= await DatabaseHelper.instance.initDb();
    return _database!;
  }

  Future<int> insertArt(ArtModal art) async {
    Database db = await instance.db;
    
    return await db.insert('art_db', art.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllArt() async {
    Database db = await instance.db;
    return await db.query('art_db');
  }
    Future<List<Map<String, dynamic>>> queryOne() async {
    Database db = await instance.db;
    return await db.query('art_db', where: 'id = ?', whereArgs: [1]);
  }

  Future<int> updateArt(ArtModal art) async {
    Database db = await instance.db;
    return await db.update('art_db', art.toMap(), where: 'id = ?', whereArgs: [art.id]);
  }

  Future<int> deleteArt(int id) async {
    Database db = await instance.db;
    debugPrint("$id user deleted");
    return await db.delete('art_db', where: 'id = ?', whereArgs: [id]);
  }

}
