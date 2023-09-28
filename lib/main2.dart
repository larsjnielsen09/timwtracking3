import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'view_data.dart';
import 'insert_data.dart';
import 'delete_data.dart';
import 'update_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeDb();
    //insertData();
    //deleteData();
    // final inserter = InsertData();
    // inserter.insertMultipleUsers(20);
    //updateData();
    //fetchData();
  }

  Future<void> initializeDb() async {
    final dbHelper = DatabaseHelper();
    print("Starting database initialization");
    final db = await dbHelper.initializeDatabase();
    print("Database initialized: ${db.isOpen ? 'Open' : 'Closed'}");
  }

  Future<void> insertData() async {
    final inserter = InsertData();
    await inserter.insertUser({'name': 'John2', 'email': 'john2@example.com'});
    print('Data inserted');
  }

  Future<void> fetchData() async {
    final viewer = ViewData();
    List<Map<String, dynamic>> users = await viewer.getUsers();
    print("Fetched users in main.dart: $users");
  }

  void deleteData() async {
    final deleter = DeleteData();
    await deleter.deleteUser(1); // Deletes the user with id = 1
    print("User deleted");
  }

  void updateData() async {
    final updater = UpdateData();
    await updater.updateUser(
        2, {'name': 'John Updated', 'email': 'john.updated@example.com'});
    print("User updated");
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Lars's database Test")),
      ),
    );
  }
}
