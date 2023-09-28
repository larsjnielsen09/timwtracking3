import 'package:flutter/material.dart';
import 'database_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _customerController = TextEditingController();
  final _dateController = TextEditingController();
  final _hoursUsedController = TextEditingController();
  final _descriptionController = TextEditingController();

DatabaseHelper get databaseHelper => DatabaseHelper.instance;

  @override
  void dispose() {
    _customerController.dispose();
    _dateController.dispose();
    _hoursUsedController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final customer = _customerController.text;
      final date = _dateController.text;
      final hoursUsed = double.parse(_hoursUsedController.text);
      final description = _descriptionController.text;

      final row = {
        'customer': customer,
        'date': date,
        'hoursUsed': hoursUsed,
        'description': description,
      };

      await DatabaseHelper.instance.insert(row);

      _customerController.clear();
      _dateController.clear();
      _hoursUsedController.clear();
      _descriptionController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data saved successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Time Tracker')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _customerController,
                decoration: InputDecoration(labelText: 'Customer'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a customer';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hoursUsedController,
                decoration: InputDecoration(labelText: 'Hours Used'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter hours used';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveData,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}