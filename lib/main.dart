import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todolist_app/firebase_options.dart';
import 'application.dart';


void main() async{

   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
await FirebaseAuth.instance.signOut();

runApp(const MyApp());
}

