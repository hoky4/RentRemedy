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
    // if (response.statusCode == 200) {
    //   setState(() {
    //     _message = 'Login Success';
    //     _messageColor = Colors.green;
    //   });
    // Map<String, dynamic> responseBodyJson = json.decode(response.body);
    // var name = responseBodyJson['firstName'];
    //
    // String rawCookie = response.headers['set-cookie']!;
    //
    // print('cookie: $rawCookie');
    // await Future.delayed(Duration(seconds: 1));

    //   Navigator.push(
    //       context,
    //       new MaterialPageRoute(
    //           builder: (context) =>
    //               SuccessScreen(name: name, rawCookie: rawCookie)));
    // } else if (response.statusCode == 400) {
    //   print('Response error: ${response.body}');
    //   setState(() {
    //     _message = 'Error logging in.';
    //     _messageColor = Colors.red;
    //   });
    // }
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
      case 400:
        throw BadRequestException(response.body.toString());

      default:
        throw Exception('Error occured while Communication with Server with'
            'StatusCode: ${response.statusCode}');
    }
  }
}
