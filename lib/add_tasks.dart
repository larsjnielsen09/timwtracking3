import 'package:flutter/material.dart';
import 'insert_data.dart'; // Make sure to import your InsertData class

class AddTasks extends StatefulWidget {
  @override
  _AddTasksState createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  final _formKey = GlobalKey<FormState>();
  final _kundeController = TextEditingController();
  final _datoController = TextEditingController(
      text: DateTime.now().toLocal().toString().split(' ')[0]);
  final _timerController = TextEditingController();

  final _beskrivelseController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  int? timer;
  DateTime? dato;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _datoController.text = selectedDate.toLocal().toString().split(' ')[0];
      });
  }

  bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tilføj Timer')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextFormField(
                controller: _kundeController,
                decoration: const InputDecoration(labelText: 'kunde'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a kunde name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Dato'),
                onSaved: (value) {
                  if (value != null) {
                    dato = DateTime.parse(value);
                  }
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a date';
                  }
                  return null;
                },
                onTap: () {
                  _selectDate(context); // Call the date picker function
                },
                readOnly:
                    true, // This ensures the keyboard does not appear when you tap the field
                controller: _datoController,
                /* (
                    text: selectedDate
                        .toLocal()
                        .toString()
                        .split(' ')[0] // Display the selected date
                    ), */
              ),
              TextFormField(
                controller: _timerController,
                decoration: const InputDecoration(labelText: 'timer'),
                validator: (value) {
                  if (value == null || value.isEmpty || !isNumeric(value)) {
                    return 'Please enter a valid number of hours';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _beskrivelseController,
                decoration: const InputDecoration(labelText: 'beskrivelse'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter beskrivelse';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final inserter = InsertData();
                    await inserter.insertKunde({
                      'kunde': _kundeController.text,
                      'dato': _datoController.text,
                      'timer': _timerController.text,
                      'beskrivelse': _beskrivelseController.text,
                    });
                    print("Task inserted");
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
