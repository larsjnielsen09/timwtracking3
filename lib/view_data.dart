import 'package:flutter/material.dart';
import 'fetch_data.dart'; // Import your FetchData class
import 'update_data.dart'; // Import your UpdateData class
import 'delete_data.dart'; // Import your DeleteData class

class ViewData extends StatefulWidget {
  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  late Future<List<Map<String, dynamic>>> futureTasks;

  @override
  void initState() {
    super.initState();
    futureTasks = FetchData().fetchAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Time oversigt')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureTasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('Ingen timer fundet');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final task = snapshot.data![index];

                return ListTile(
                  title: Text('Kunde: ${task['kunde']}'),
                  subtitle: Text(
                      'Dato: ${task['dato']}\nTimer: ${task['timer']}\nBeskrivelse: ${task['beskrivelse']}'),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdatePage(task: task),
                            ),
                          );
                          if (result == 'updated') {
                            setState(() {
                              futureTasks = FetchData()
                                  .fetchAllTasks(); // Refresh the list
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Deletion'),
                                content: const Text(
                                    'Are you sure you want to delete this record?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await DeleteData().deleteKunde(
                                          task['id']); // Your delete logic here
                                      setState(() {
                                        futureTasks = FetchData()
                                            .fetchAllTasks(); // Refresh the list
                                      });
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
