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
    final isLight = false;
    return MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      theme: isLight?ThemeData.light(): ThemeData.dark(),
      home: TodoList(),
    );
  }
}
