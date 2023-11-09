import 'package:flutter/material.dart';
import 'package:todolist_app/widgets/update_task.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';


class TaskItem extends StatefulWidget {

  final Task? task;
  final VoidCallback onDelete;

  TaskItem(Task taskItem, {Key? key, required this.task, required this.onDelete, required Type onUpdate,}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Checkbox(
                    value: isCompleted,
                    onChanged: (value) async {

                      setState(() {
                        isCompleted = value!;
                      });
                      
                    },
                  ),
                  Icon(Icons.task),
                ],
              ),
              title: Text(
                widget.task!.title,
                style: TextStyle(fontWeight: FontWeight.bold,decoration: isCompleted ? TextDecoration.lineThrough : null,),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task!.description),
                  Text(
                    widget.task?.date != null
                        ? 'Date: ${DateFormat('dd/MM/yyyy').format(widget.task!.date)}'
                        : 'Date: N/A',
                  ),
                  Text('Category: ${widget.task!.category}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateTasks(task: widget.task, taskId: widget.task!.id),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: widget.onDelete,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
