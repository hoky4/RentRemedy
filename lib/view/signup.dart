import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController txtFirstName = TextEditingController();
  final TextEditingController txtLastName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(36),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Text(
                    "Signup",
                    style: GoogleFonts.pacifico(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.black),
                  ),
                  SizedBox(height: 25),
                  firstNameInput(),
                  lastNameInput(),
                  emailInput(),
                  passwordInput(),
                  btnSignup(),
                  btnSecondary(),
                ],
              ))),
    ));
  }

  Widget firstNameInput() {
    return Padding(
        padding: EdgeInsets.only(top: 24),
        child: TextFormField(
          controller: txtFirstName,
          keyboardType: TextInputType.name,
          decoration:
              InputDecoration(hintText: 'First Name', icon: Icon(Icons.person)),
          validator: (text) => text!.isEmpty ? 'First Name is required' : null,
          onChanged: (value) {},
        ));
  }

  Widget lastNameInput() {
    return Padding(
        padding: EdgeInsets.only(top: 24),
        child: TextFormField(
          controller: txtLastName,
          keyboardType: TextInputType.name,
          decoration:
              InputDecoration(hintText: 'Last Name', icon: Icon(Icons.person)),
          validator: (text) => text!.isEmpty ? 'Last Name is required' : null,
        ));
  }

  Widget emailInput() {
    return Padding(
        padding: EdgeInsets.only(top: 24),
        child: TextFormField(
          controller: txtEmail,
          keyboardType: TextInputType.emailAddress,
          decoration:
              InputDecoration(hintText: 'Email', icon: Icon(Icons.email)),
          validator: (text) => text!.isEmpty ? 'Email is required' : null,
        ));
  }

  Widget passwordInput() {
    return Padding(
        padding: EdgeInsets.only(top: 24),
        child: TextFormField(
          controller: txtPassword,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration:
              InputDecoration(hintText: 'Password', icon: Icon(Icons.lock)),
          validator: (text) => text!.isEmpty ? 'Password is required' : null,
        ));
  }

  Widget btnSignup() {
    var statusCode = '';
    return Padding(
        padding: EdgeInsets.only(top: 48),
        child: Container(
            height: 60,
            width: 200,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    // side: BorderSide(color: Colors.red)
                  ),
                ),
              ),
              child: Text(
                'Sign up',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  print('ok');
                  statusCode = await signup(txtFirstName.text, txtLastName.text,
                      txtEmail.text, txtPassword.text);
                  print('Status Code: $statusCode');

                  if (statusCode == '201') {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => Login()));
                  }
                } else {
                  print('not ok');
                }
              },
            )));
  }

  Widget btnSecondary() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(65, 20, 0, 0),
        child: Row(children: [
          Text(
            'Already have Account ? ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text(
              'Login',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ]));
  }
}

Future<String> signup(firstName, lastName, email, password) async {
  print("signup called");
  var url = "https://localhost:5001/api/users";
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'roles': [0]
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    print('Response ${response.body}');
    return '${response.statusCode}';
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print('Error Status: ${response.statusCode}');
    throw Exception('Failed to create user.');
  }
}
