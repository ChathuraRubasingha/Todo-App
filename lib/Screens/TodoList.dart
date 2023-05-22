import 'package:flutter/material.dart';
import 'package:todoapp/Screens/AddTodo.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage, label: Text('Add Todo')),
    );
  }

  void navigateToAddPage() {
  final route = MaterialPageRoute(
    builder: (context) => AddTodo(),
  );
  Navigator.push(context, route);
}

}

