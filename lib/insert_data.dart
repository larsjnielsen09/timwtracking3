//insert_data.dart

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class InsertData {
  final dbHelper = DatabaseHelper();

  Future<void> insertKunde(Map<String, Object> task) async {
    final db = await dbHelper.initializeDatabase();

    await db.insert(
      'task',
      task,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMultipleUsers(int numberOfUsers) async {
    final db = await dbHelper.initializeDatabase();

    for (int i = 0; i < numberOfUsers; i++) {
      final name = "User_${i + 1}";
      final email = "user${i + 1}@example.com";

      final user = {
        'name': name,
        'email': email,
      };

      await db.insert(
        'User',
        user,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
