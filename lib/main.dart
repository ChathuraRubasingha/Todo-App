import 'Screens/SideBar.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Screens/TodoList.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Todo List'),
          backgroundColor: Colors.black,
           actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Handle search action
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                // Handle notification action
              },
            ),
          ],
        ),
        drawer: Sidebar(), // Add the Sidebar widget as the drawer
        body: Container(
          child: const TodoList()// Main content of your app
        ),
      ),
    );
  }
}