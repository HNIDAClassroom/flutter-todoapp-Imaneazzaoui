import 'package:cloud_firestore/cloud_firestore.dart'; import '../models/task.dart';
class FirestoreService{
final CollectionReference tasks= FirebaseFirestore.instance.collection('tasks'); 

Future<void> addTask( Task task) {
return    FirebaseFirestore.instance.collection('tasks').add( {
'taskTitle': task.title.toString(),
'taskDesc': task.description.toString(), 
'taskCategory': task.category.toString(),
'taskDate': Timestamp.fromDate(task.date), },
); 

}

Stream <QuerySnapshot> getTasks() {
final taskStream= tasks.snapshots(); 
return taskStream;
}

Future<void> deleteTaskByTitle(String title) async {
    final taskToDelete = await tasks
        .where('taskTitle', isEqualTo: title)
        .get();

    if (taskToDelete.docs.isNotEmpty) {
      for (var doc in taskToDelete.docs) {
        await tasks.doc(doc.id).delete();
      }
    }
  }

Future<void> updateTaskByTitle(String title, Task updatedTask) async {
  final taskToUpdate = await tasks
      .where('taskTitle', isEqualTo: title)
      .get();

  if (taskToUpdate.docs.isNotEmpty) {
    String correctDocumentID = taskToUpdate.docs[0].id;

    await tasks.doc(correctDocumentID).update({
      'taskTitle': updatedTask.title.toString(),
      'taskDesc': updatedTask.description.toString(),
      'taskCategory': updatedTask.category.toString(),
      'taskDate': Timestamp.fromDate(updatedTask.date),
    });
  } else {
    print("Task not found in Firestore.");
  }
}

  updateTask(String id, Task updatedTask) {}

  Future<void> updateTaskDone(
    DocumentReference reference, bool isDone
  ){
    return reference.update({'isDone': isDone});
  }

}



