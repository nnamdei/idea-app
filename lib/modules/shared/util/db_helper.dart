import 'package:idea/modules/shared/models/idea.dart';
import 'package:idea/modules/shared/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:io' as io;

class DBHelper {
  static Database? _database;
  final String usersTable = 'users';
  final String ideasTable = 'ideas';
  final String votesTable = 'votes';

  Future<Database> initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'ideas.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $usersTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE $ideasTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            author TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE $votesTable (
            idea_id INTEGER,
            user_id INTEGER,
            is_upvote INTEGER
          )
        ''');
      },
    );
  }
}

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  Database? _database;

  factory DatabaseProvider() {
    return _instance;
  }

  DatabaseProvider._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // final String databasePath = await getDatabasesPath();
    // const String databaseName = 'my_database.db';
    // final String path = '$databasePath/$databaseName';
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'my_database.db');

    final Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
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
      },
    );

    return database;
  }

  Future<void> createUser(User user) async {
    final Database db = await database;

    await db
        .insert(
      'users',
      user.toMap(),
    ).then((value) {
      print(value);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<User?> getUserByUsername(String username) async {
    final Database db = await database;
    final result =
        await db.query('users', where: 'username = ?', whereArgs: [username]);
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<void> createIdea(Idea idea) async {
    final Database db = await database;
    await db.insert('ideas', idea.toMap());
  }

  Future<List<Idea>> getIdeas() async {
    final Database db = await database;
    final results = await db.query('ideas');
    return results.map((map) => Idea.fromMap(map)).toList();
  }

  Future<Idea?> getIdea(int id) async {
    final Database db = await database;
    final result = await db.query('ideas', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Idea.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<void> upvoteIdea(int ideaId) async {
    final Database db = await database;
    await db.update('ideas', {'upvotes': db.rawUpdate('upvotes + 1')},
        where: 'id = ?', whereArgs: [ideaId]);
  }

  Future<void> downvoteIdea(int ideaId) async {
    final Database db = await database;
    await db.update('ideas', {'downvotes': db.rawUpdate('downvotes + 1')},
        where: 'id = ?', whereArgs: [ideaId]);
  }

  Future<void> deleteDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, "my_database.db");
    // Check if the database file exists before attempting to delete it
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }


}
