import 'package:flutter/material.dart';
import 'package:todolist_app/widgets/tasks.dart';

class Login extends StatefulWidget {
  const Login();

  @override
  LoginPage createState() {
  return LoginPage();
  }
}

class LoginPage extends State<Login> {
String username = '';
String password = '';
Future<String?> handlePressed() async{

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Tasks(),
      ),
    );

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hello world!")),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: IntrinsicHeight(
              child: SizedBox(
              height: 350,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () { handlePressed();},
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}
