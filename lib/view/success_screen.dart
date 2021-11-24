import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class SuccessScreen extends StatefulWidget {
  final String name;
  http.Response response;

  SuccessScreen({Key? key, required this.name, required this.response})
      : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  Map<String, String> headers = {};

  @override
  Widget build(BuildContext context) {
    http.Response resp;

    return Scaffold(
        appBar: AppBar(
          title: Text('Successfully Logged in'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                updateCookie(widget.response);
                headers['Content-Type'] = 'application/json; charset=UTF-8';
                print('headers: ${headers}');
                resp = await logout();

                if (resp.statusCode == 204) {
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => Login()));
                }
              },
            )
          ],
        ),
        body: Center(child: Text('Welcome, ${widget.name}!')));
  }

  void updateCookie(http.Response response) {
    var rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');

      headers['Cookie'] = (index == -1)
          ? rawCookie
          : json.decode(rawCookie.substring(0, index));
    }
  }

  Future<http.Response> logout() async {
    var url = "https://10.0.2.2:5001/api/logout";
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(<String, dynamic>{}),
    );
    print('response: ${response.body}');
    return response;
  }
}
