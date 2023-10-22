import 'package:flutter/material.dart';
import 'package:todolist_app/login.dart';
import 'package:todolist_app/widgets/tasks.dart';


void main() {
  runApp(
 MaterialApp(
    theme: ThemeData(
    appBarTheme: const AppBarTheme(elevation: 0),
    useMaterial3: true,
  ),
      home: const Login(),
    ),
  );
}

