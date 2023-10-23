import 'dart:io';

import 'package:idea/modules/shared/models/idea.dart';
import 'package:idea/modules/shared/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBUtil {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'data.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL
          )
        ''');

    await db.execute('''
          CREATE TABLE ideas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            upvotes INTEGER NOT NULL DEFAULT 0,
            downvotes INTEGER NOT NULL DEFAULT 0
          )
        ''');
  }

  Future<User> insert(User user) async {
    var dbClient = await database;
    await dbClient?.insert('users', user.toMap());
    return user;
  }

  Future<Idea> insertIdea(Idea idea) async {
    var dbClient = await database;
    await dbClient?.insert('ideas', idea.toMap());
    return idea;
  }

  Future<List<Idea>> getIdeaList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('ideas');
    return queryResult.map((result) => Idea.fromMap(result)).toList();
  }

  Future<List<User>?> getUserList() async {
    var dbClient = await database;
    final List<Map<String, Object?>>? queryResult =
        await dbClient?.query('users');
    return queryResult?.map((result) => User.fromMap(result)).toList();
  }

  Future<int> upvoteIdea(Idea idea) async {
    var dbClient = await database;
    return await dbClient!.update('ideas', idea.upVotesMap(),
        where: "id = ?", whereArgs: [idea.id]);
  }

  Future<int> downvoteIdea(Idea idea) async {
    var dbClient = await database;
    return await dbClient!.update('ideas', idea.downVotesMap(),
        where: "id = ?", whereArgs: [idea.id]);
  }

  Future<List<Idea>> getIdeaId(int id) async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryIdResult =
        await dbClient!.query('ideas', where: 'id = ?', whereArgs: [id]);
    return queryIdResult.map((e) => Idea.fromMap(e)).toList();
  }

  Future<Idea?> getIdea(int id) async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryIdResult =
        await dbClient!.query('ideas', where: 'id = ?', whereArgs: [id]);
    if (queryIdResult.isNotEmpty) {
      return Idea.fromMap(queryIdResult.first);
    } else {
      return null;
    }
  }

  Future<User?> getUserByUsername(String username) async {
    var dbClient = await database;
    final result = await dbClient!
        .query('users', where: 'username = ?', whereArgs: [username]);
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<void> deleteDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "user.db");
    // Check if the database file exists before attempting to delete it
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}

