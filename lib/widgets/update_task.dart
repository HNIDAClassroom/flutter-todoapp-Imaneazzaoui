import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';
import '../services/firestore.dart';


class UpdateTasks extends StatefulWidget {
  final Task? task;
  final String taskId;

  UpdateTasks({required this.task, required this.taskId});

  @override
  _UpdateTasksState createState() => _UpdateTasksState(task: task);
}

class _UpdateTasksState extends State<UpdateTasks> {
  FirestoreService firestoreService = FirestoreService();
  Task? task;

  _UpdateTasksState({required this.task});

  String _selectedCategory = 'Studies';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  List<String> _categories = ['Studies', 'Category 2', 'Category 3'];

  @override
  void initState() {
    super.initState();
    if (task != null && task?.date != null) {
      _titleController.text = task!.title;
      _descriptionController.text = task!.description;
      _dateController.text = DateFormat('yyyy-MM-dd').format(task!.date);
      _selectedCategory = task!.category;
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                onTap: () async {
                },
              ),
              DropdownButtonFormField(
                value: _selectedCategory,
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String updatedTitle = _titleController.text;
                    String updatedDescription = _descriptionController.text;
                    DateTime updatedDate = DateTime.parse(_dateController.text);
                    String updatedCategory = _selectedCategory;

                    Task updatedTask = Task(
                      title: updatedTitle,
                      description: updatedDescription,
                      date: updatedDate,
                      category: updatedCategory,
                    );

                    try {
                      await firestoreService.updateTaskByTitle(task!.title, updatedTask);
                    } catch (e) {
                      print("Error updating task: $e");
                      print("Document ID: ${task!.id}");
                    }
                  }
                  Navigator.pop(context);
                },
                child: Text('Update Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
