                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await DeleteData().deleteKunde(task['id']);
                          setState(() {
                            futureTasks = FetchData().fetchAllTasks();
                          });
                        },
                      ),
