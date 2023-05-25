import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodo extends StatefulWidget {
  final Map? todo;
  const AddTodo({
    super.key,
    this.todo,
  });

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo["title"];
      final description = todo["description"];
      descriptionController.text = description;
      titleController.text = title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isEdit ? 'Edit Todo' : 'Add Todo'),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: "Title"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(hintText: "Description"),
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 8,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: isEdit ? UpdateData : submitData,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(isEdit ? 'Update' : 'Submit'),
                ))
          ],
        ));
  }

  Future<void> submitData() async {
    //Get the Data from form
    final title = titleController.text;
    final description = descriptionController.text;

    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    //Submit data to the Server
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-type': 'application/json'},
    );
    //Show success or fail
    if (response.statusCode == 201) {
      titleController.text = '';
      descriptionController.text = '';
      ShowSuccessMessage('Creation Success');
    } else {
      ShowErrorMessage('Creation failed');
    }
  }

  Future<void> UpdateData() async {
    //Get the Data from form
    final todo = widget.todo;
    if (todo == null) {
      print('cannot');
      return;
    }
    final id = todo['_id'];
    final isCompleted = todo['is_completed'];
    final title = titleController.text;
    final description = descriptionController.text;

    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };
    // Submit data to the Server
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {'Content-type': 'application/json'},
    );
    //Show success or fail
    if (response.statusCode == 200) {
      titleController.text = '';
      descriptionController.text = '';
      ShowSuccessMessage('Updation Success');
    } else {
      ShowErrorMessage('Updation failed');
    }
  }

  void ShowSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      backgroundColor: const Color.fromARGB(255, 2, 150, 7),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void ShowErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
