import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserForm(),
    );
  }
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Call the web service to insert the user data
                    _insertUserData();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _insertUserData() async {
    // Call the web service here
    final url = 'http://localhost/exercice_mobile/webservice.php';
    final response = await http.post(Uri.parse(url), body: {
      'name': _name,
      'email': _email,
      'password': _password,
    });

    // Check the response and show the appropriate message to the user
    if (response.statusCode == 200) {
      // Show a success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User data inserted successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to insert user data'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
