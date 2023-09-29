import 'package:flutter/material.dart';

import 'update_data_old.dart';

class UpdatePage extends StatefulWidget {
  final Map<String, dynamic> task;

  const UpdatePage({required this.task});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _kundeController;
  late TextEditingController _datoController;
  late TextEditingController _timerController;
  late TextEditingController _beskrivelseController;

  DateTime selectedDate = DateTime.now();
  int? timer;
  DateTime? dato;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      //initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _datoController.text = selectedDate.toLocal().toString().split(' ')[0];
      });
  }

  @override
  void initState() {
    super.initState();
    _kundeController = TextEditingController(text: widget.task['kunde']);
    _datoController = TextEditingController(text: widget.task['dato']);
    _timerController = TextEditingController(text: widget.task['timer']);
    _beskrivelseController =
        TextEditingController(text: widget.task['beskrivelse']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Opdater kunde"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              // Your form fields here, pre-filled with user data

              TextFormField(
                controller: _kundeController,
                // validation logic here
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
              ),

              TextFormField(
                controller: _timerController,
                keyboardType: TextInputType.number,
              ),

              TextFormField(
                controller: _beskrivelseController,
                // validation logic here
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await UpdateData().updateKunde({
                      'id': widget.task['id'],
                      'kunde': _kundeController.text,
                      'dato': _datoController.text,
                      'timer': _timerController.text,
                      'beskrivelse': _beskrivelseController.text,
                    });
                    Navigator.pop(context, 'updated');
                  }
                },
                child: const Text("Opdater"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
