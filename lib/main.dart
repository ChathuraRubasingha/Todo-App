import 'package:flutter/material.dart';
import 'package:todoapp/Screens/TodoList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: TodoList(),
    );
  }
}

