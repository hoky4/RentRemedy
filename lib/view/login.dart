import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:rentremedy_mobile/models/user.dart';
import 'package:rentremedy_mobile/view/signup.dart';
import 'package:rentremedy_mobile/view/success_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _message = '';
  late Color _messageColor = Colors.black;
  User user = User('', '');

  @override
  Widget build(BuildContext context) {
    http.Response response;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: SingleChildScrollView(
          child: Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Text(
                      "Login",
                      style: GoogleFonts.pacifico(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Colors.black),
                    ),
                    SizedBox(height: 25),
                    txtMessage(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: user.email),
                        onChanged: (value) {
                          user.email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          } else if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return 'Enter valid email';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          icon: Icon(Icons.email),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blue)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: TextEditingController(text: user.password),
                        onChanged: (value) {
                          user.password = value;
                        },
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          icon: Icon(Icons.lock),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.blue)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Colors.red)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        height: 50,
                        width: 400,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(8.0),
                            primary: Colors.white,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              response = await login(user.email, user.password);
                              if (response.statusCode == 200) {
                                setState(() {
                                  _message = 'Login Success';
                                  _messageColor = Colors.green;
                                });
                                Map<String, dynamic> responseJson =
                                    json.decode(response.body);
                                var name = responseJson['firstName'];
                                await Future.delayed(Duration(seconds: 1));
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            SuccessScreen(name: name)));
                              } else if (response.statusCode == 400) {
                                print('Response error: ${response.body}');
                                setState(() {
                                  _message = 'Error logging in.';
                                  _messageColor = Colors.red;
                                });
                              }
                            } else {
                              print('Missing required fields');
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(65, 20, 0, 0),
                        child: Row(children: [
                          Text(
                            "Don't have Account ? ",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ])),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget txtMessage() {
    return Text(
      _message,
      style: TextStyle(
          fontSize: 16, color: _messageColor, fontWeight: FontWeight.bold),
    );
  }
}

Future<http.Response> login(email, password) async {
  var url = "https://10.0.2.2:5001/api/login";
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'email': email,
      'password': password,
    }),
  );

  return response;
}
