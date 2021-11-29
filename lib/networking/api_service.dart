import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:rentremedy_mobile/networking/api_exception.dart';

class ApiService {
  signup(firstName, lastName, email, password) async {
    var url = "https://10.0.2.2:5001/api/users";
    var responseJson;
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

      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }

    // final responseData = json.decode(response.body);
    // print('responseData: ${responseData}');
    // print('error: ${responseData['errors']}');
    //
    // if (responseData['errors'] != null) {
    //   print('throws');
    //   throw HttpException(responseData['errors'].toString());
    // }

    // if (response.statusCode == 201) {
    //   await Future.delayed(Duration(seconds: 1));
    //   // Navigator.push(
    //   //     context, new MaterialPageRoute(builder: (context) => Login()));
    // } else {
    //   // If the server did not return a 201 CREATED response,
    //   // then throw an exception.
    //   throw Exception('Failed to create album.');
    // }
    /*else if (response.statusCode == 400) {
      print('Response error: ${response.body}');
      setState(() {
        _message = 'Error signing up.';
        _messageColor = Colors.red;
      });
    }

     */
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 201:
        var responseJson = json.decode(response.body.toString());
        print('response $responseJson');
        return responseJson;
      case 400:
        // final responseData = json.decode(response.body);
        // print('responseData: ${responseData}');

        throw BadRequestException(response.body.toString());

      default:
        throw Exception('Error occured while Communication with Server with'
            'StatusCode: ${response.statusCode}');
    }
  }
}
