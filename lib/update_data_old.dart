// update_data.dart

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

class UpdateData {
  final dbHelper = DatabaseHelper();

  Future<void> updateKunde(Map<String, dynamic> updatedKunde) async {
    final db = await dbHelper.initializeDatabase();
    await db.update(
      'task',
      updatedKunde,
      where: 'id = ?',
      whereArgs: [updatedKunde['id']],
    );
  }

/*   Future<void> updateUser(Map<String, dynamic> updatedUser) async {
    final db = await dbHelper.initializeDatabase();
    await db.update(
      'task',
      updatedUser,
      where: 'id = ?',
      whereArgs: [updatedUser['id']],
    );
  } */
}
