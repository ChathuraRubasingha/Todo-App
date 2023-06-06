import 'package:flutter/material.dart';
import 'package:todoapp/Screens/Login.dart';
import 'package:todoapp/Screens/TodoList.dart';
import 'package:todoapp/screens/Registration.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegistrationScreen(),
        '/todoList': (context) => TodoList(), // Main content of your app
      },
    );
  }
}
