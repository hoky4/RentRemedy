import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class SuccessScreen extends StatefulWidget {
  final String name;
  final String rawCookie;

  SuccessScreen({Key? key, required this.name, required this.rawCookie})
      : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Successfully Logged in'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                logout(widget.rawCookie);
              },
            )
          ],
        ),
        body: Center(child: Text('Welcome, ${widget.name}!')));
  }

  logout(rawCookie) async {
    var url = "https://10.0.2.2:5001/api/logout";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'cookie': rawCookie,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{}),
    );

    if (response.statusCode == 204) {
      await Future.delayed(Duration(seconds: 1));
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => Login()));
    }
  }
}
