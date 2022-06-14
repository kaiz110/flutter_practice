import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Tasks {
  final int? id;
  final String title;
  final String content;
  Tasks({this.id, required this.title, required this.content});

  factory Tasks.fromMap(Map<String, dynamic> map) =>
      Tasks(id: map['id'], title: map['title'], content: map['content']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}

class TasksDatabaseHelper {
  TasksDatabaseHelper.privateConstructer();
  static final TasksDatabaseHelper instance =
      TasksDatabaseHelper.privateConstructer();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY,
        title TEXT,
        content TEXT
      )
    ''');
  }

  Future<List<Tasks>> getTasks() async {
    Database db = await instance.database;
    var tasks = await db.query('tasks', orderBy: 'title');
    List<Tasks> taskList =
        tasks.isNotEmpty ? tasks.map((e) => Tasks.fromMap(e)).toList() : [];
    return taskList;
  }

  Future<int> add(Tasks task) async {
    Database db = await instance.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Tasks task) async {
    Database db = await instance.database;
    return await db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }
}
