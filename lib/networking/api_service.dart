import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rentremedy_mobile/networking/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final storage = FlutterSecureStorage();
  final myKey = 'myCookie';

  signup(firstName, lastName, email, password) async {
    var url = "https://10.0.2.2:5001/api/users";
    try {
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

      _returnResponse(response);
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }
  }

  login(email, password) async {
    var url = "https://10.0.2.2:5001/api/login";
    var responseJson;

    try {
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

      _returnResponse(response);
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }
  }

  logout() async {
    var url = "https://10.0.2.2:5001/api/logout";
    String rawCookie = '';
    await readFromSecureStorage('myCookie').then((value) => rawCookie = value!);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'cookie': rawCookie,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{}),
      );

      _returnResponse(response);
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }
  }

  dynamic _returnResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> responseBodyJson = json.decode(response.body);
        var name = responseBodyJson['firstName'];

        // obtain shared preferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('name', name);

        String rawCookie = response.headers['set-cookie']!;
        writeToSecureStorage(myKey, rawCookie);
        print('cookie: $rawCookie');

        return;
      case 201:
        var responseJson = json.decode(response.body.toString());
        print('201-response $responseJson');
        return responseJson;
      case 204:
        print('statusCoe: 204-response');
        return;
      case 400:
        throw BadRequestException(response.body.toString());
      default:
        throw Exception('Error occured while Communication with Server with'
            'StatusCode: ${response.statusCode}');
    }
  }

  Future writeToSecureStorage(myKey, rawCookie) async {
    await storage.write(key: myKey, value: rawCookie);
  }

  Future<String?> readFromSecureStorage(myKey) async {
    String? secret = await storage.read(key: myKey);
    return secret;
  }
}
