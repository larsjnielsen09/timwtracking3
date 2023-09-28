// database_helper.dart

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Future<Database> initializeDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT, kunde TEXT, dato TEXT, timer TEXT, beskrivelse TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }
}
