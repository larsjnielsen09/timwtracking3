import 'database_helper.dart'; // Import your DatabaseHelper class

class FetchData {
  final dbHelper = DatabaseHelper(); // Create a new instance of DatabaseHelper

  Future<List<Map<String, dynamic>>> fetchAllTasks() async {
    final db = await dbHelper
        .initializeDatabase(); // Use the initializeDatabase method from DatabaseHelper
    return await db.query('task', orderBy: 'id DESC');
  }
}
