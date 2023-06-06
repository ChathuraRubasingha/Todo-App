import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapp/Screens/RegistrationForm.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
        backgroundColor: Colors.black,
      ),
      body: RegistrationForm(),
    );
  }
}
