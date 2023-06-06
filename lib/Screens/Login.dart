import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapp/Screens/LoginForm.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.black,
      ),
      body: LoginForm(),
    );
  }
}
