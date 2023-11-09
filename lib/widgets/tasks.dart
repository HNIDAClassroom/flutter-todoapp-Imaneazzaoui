import '../services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/widgets/new_task.dart';
import 'package:todolist_app/widgets/tasks_list.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../models/task.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService= FirestoreService();
  final List<Task> _registeredTasks = [
  Task(
    title: 'Apprendre Flutter',
    description: 'Suivre le cours pour apprendre de nouvelles compétences',
    date: DateTime.now(),
    category: Category.work, 
  ),
  Task(
    title: 'Faire les courses',
    description: 'Acheter des provisions pour la semaine',
    date: DateTime.now().subtract(Duration(days: 1)),
    category: Category.shopping, 
  ),
  Task(
    title: 'Rediger un CR',
    description: '',
    date: DateTime.now().subtract(Duration(days: 2)),
    category: Category.personal, 
  ),
  // Add more tasks with descriptions as needed
];

void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(onAddTask: _addTask,),
    );
  }

void _addTask(Task task) { 
setState(() {
_registeredTasks.add(task); 
firestoreService.addTask(task); 
Navigator.pop(context);
}); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 172, 195, 214),
      appBar: AppBar(
        title: const Center ( child: Text('Flutter ToDoList'),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), 
          onPressed: () {
        FirebaseAuth.instance.signOut();}
        ),
        actions: [
          IconButton(
            onPressed: _openAddTaskOverlay,
            icon: Ink(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color.fromARGB(244, 180, 178, 170)),
                    child : const Padding(padding: EdgeInsets.all(8),
                    child: const Icon(Icons.add),)
            ),
          ),

        ],
      ),

      body: TasksList(tasks: _registeredTasks),
    );
  }
}
