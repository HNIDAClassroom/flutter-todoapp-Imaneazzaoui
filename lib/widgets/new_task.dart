import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key, this.task, required this.onAddTask}) : super(key: key);

  final Task? task;
  final void Function(Task task) onAddTask;

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? taskDate;
  String? selectedCategory;
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      taskDate = widget.task!.date;
      selectedCategory = widget.task!.category;
    }
  }


  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitTaskData() {
    if (_titleController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text(
              'Merci de saisir le titre de la tâche à ajouter dans la liste'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    if (taskDate == null || selectedCategory == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Merci de sélectionner une date et une catégorie'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    final newTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      date: taskDate,
      category: selectedCategory, 
    );

    widget.onAddTask(newTask);

    _titleController.clear();
    _descriptionController.clear();
    dateController.clear();

    setState(() {
      taskDate = null;
      selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
      return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: _descriptionController,
            maxLength: 200,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 16),
              labelText: 'Description',
            ),
          ),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: "Enter Date",
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null) {
                String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  dateController.text = formattedDate;
                  taskDate = pickedDate;
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
          DropdownButton<String>(
            value: selectedCategory,
            items: [
              DropdownMenuItem(
                value: 'Studies',
                child: Text('Studies'),
              ),
              DropdownMenuItem(
                value: 'Category 2',
                child: Text('Category 2'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
              });
            },
            hint: Text('Select a Category'),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _submitTaskData();
                },
                child: Text('Save Task'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
