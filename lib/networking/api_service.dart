import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rentremedy_mobile/networking/api_exception.dart';

class ApiService {
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

  dynamic login(email, password) async {
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

      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }

    return responseJson;
  }

  logout(rawCookie) async {
    var url = "https://10.0.2.2:5001/api/logout";
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

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> responseBodyJson = json.decode(response.body);
        var name = responseBodyJson['firstName'];
        String rawCookie = response.headers['set-cookie']!;
        print('cookie: $rawCookie');
        return [name, rawCookie];
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
}
