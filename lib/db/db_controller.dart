import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  static final DbController _instance = DbController._();
  late Database _database;

  factory DbController() {
    return _instance;
  }

  DbController._();

  Database get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'db.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE azkary ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title TEXT'
            ')');
        await db.execute('CREATE TABLE alhamed ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title TEXT'
            ')');
      },
      onUpgrade: (db, oldVersion, newVersion) {},
      onDowngrade: (db, oldVersion, newVersion) {},
    );
  }
}
