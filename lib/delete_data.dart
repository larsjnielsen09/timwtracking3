// delete_data.dart

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class DeleteData {
  final dbHelper = DatabaseHelper();

  Future<void> deleteKunde(int id) async {
    final db = await dbHelper.initializeDatabase();

    await db.delete(
      'task',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
