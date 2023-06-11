import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
             
              SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform login logic here
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    // Call your login API or handle the login process

                    // Clear the form after successful login
                    _formKey.currentState?.reset();
                    _emailController.clear();
                    _passwordController.clear();

                    // Show a success message or navigate to the next screen
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Login Successful'),
                        content: Text('You have successfully logged in.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/todoList');
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
               TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                
                child: Text('Sign Up'),
              ),
            ],
            
          ),
        ),
      ),
      
    );
  }
}
