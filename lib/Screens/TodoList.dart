import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todoapp/Screens/AddTodo.dart';
import 'package:http/http.dart' as http;

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool isLoading = true;
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo List",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(child: Text('No Todo Item')),
            child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.all(5),
              itemBuilder: (context, index) {
                final item = items[index];
                final id = item['_id'] as String;
                final title = item['title'];
                bool isChecked = item[
                    'is_completed']; // Get the checkbox state from the item

                return Card(
                  child: ListTile(
                    leading: Checkbox(
                      value:
                          isChecked, // Provide a default value in case isChecked is null
                      onChanged: (newValue) {
                        setState(() {
                          isChecked =
                              newValue!; // Update the checkbox state locally
                          updateTodoItem(id, isChecked,
                              title); // Update the item in the database
                        });
                      },
                    ),
                    title: Text(item['title']),
                    subtitle: Text(item['description']),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'edit') {
                          //Open Edit form
                          navigateToEditPage(item);
                        } else if (value == 'delete') {
                          //Delete and refresh
                          deleteById(id);
                        }
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text('Edit'),
                            value: 'edit',
                          ),
                          PopupMenuItem(
                            child: Text('Delete'),
                            value: 'delete',
                          ),
                        ];
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text('Add New'),
        backgroundColor: Color.fromARGB(255, 41, 78, 247),
        foregroundColor: Colors.white,
      ),
    );
  }

  void navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodo(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToEditPage(Map<String, dynamic> item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodo(todo: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    // Delete the item
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      showErrorMessage('Deletion Failed');
    }
  }

  Future<void> fetchTodo() async {
    final url = 'http://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result.map<Map<String, dynamic>>((item) {
          return item;
        }).toList();
      });
    } else {
      // show error
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> updateTodoItem(String id, bool isChecked, String title) async {
    print(id);
    print(isChecked);
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);

    final updatedItem = {
      'title': title,
      'is_completed': true,
    };

    final response = await http.put(
      uri,
      body: jsonEncode(updatedItem),
      headers: {'Content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      showSuccessMessage('You finished the Task. Congratulations');
    } else {
      showErrorMessage('Failed to Done');
    }
    fetchTodo();
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
