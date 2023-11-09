import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/widgets/task_item.dart';
import 'package:todolist_app/widgets/update_task.dart';
import '../services/firestore.dart';

import '../models/task.dart';

class TasksList extends StatelessWidget {
  
  TasksList({super.key, required List<Task> tasks});



  @override
  Widget build(BuildContext context) {
    
    FirestoreService firestoreService = FirestoreService();


    return StreamBuilder<QuerySnapshot>(
    stream: firestoreService.getTasks(), 
    builder: (context, snapshot) {

     final taskLists = snapshot.data!.docs;
     List<Task> taskItems = [];
     for (int index = 0; index < taskLists.length; index++) {
      DocumentSnapshot document = taskLists[index];
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String title = data['taskTitle'];
      String description = data['taskDesc']; 
      DateTime date = (data['taskDate'] as Timestamp).toDate();
      String categoryString= data['taskCategory'];

      Task task = Task(title: title,
      description: description,
      date: date,
      category: categoryString, 
      );
      taskItems.add(task);
      }

      return ListView.builder(
      itemCount: taskItems.length, itemBuilder: (ctx, index) {
        void deleteTask() {
            final taskToDelete = taskItems[index];
            firestoreService.deleteTaskByTitle(taskToDelete.title); 
          }


      return TaskItem(taskItems[index], onDelete: deleteTask , onUpdate: UpdateTasks, task: taskItems[index],  ); },
      );
     },
 
);

  }
}
