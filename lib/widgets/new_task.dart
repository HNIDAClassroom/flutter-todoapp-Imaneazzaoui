import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print('Vous avez appuyé sur Save');
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
