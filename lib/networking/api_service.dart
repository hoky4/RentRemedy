import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rentremedy_mobile/models/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/models/User/user.dart';
import 'package:rentremedy_mobile/networking/api.dart';
import 'package:rentremedy_mobile/networking/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final storage = FlutterSecureStorage();
  final myKey = 'myCookie';
  var cookie = '';

  signLeaseAgreement(id) async {
    await readFromSecureStorage('myCookie');

    final response = await http.post(
      Uri.parse('$LEASEAGREEMENTS/$id/signatures'),
      headers: <String, String>{
        'cookie': cookie,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{}),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      _handleError(response);
    }
  }

  joinLeaseAgreement(id) async {
    await readFromSecureStorage('myCookie');

    final response = await http.post(
      Uri.parse('$LEASEAGREEMENTS/$id/join'),
      headers: <String, String>{
        'cookie': cookie,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{}),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      _handleError(response);
    }
  }

  Future<LeaseAgreement?> getLeaseAgreement(code) async {
    await readFromSecureStorage('myCookie');

    final response = await http.get(Uri.parse('$LEASEAGREEMENTS?code=$code'),
        headers: <String, String>{
          'cookie': cookie,
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      print('response: ${response.body}');
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      
      List<dynamic> leaseAgreements = responseMap['leaseAgreements'];
      if (leaseAgreements.isEmpty) {
        throw NotFoundException("No Results Found");
      }

      Map<String, dynamic> leaseAgreementMap = responseMap['leaseAgreements'][0];
      var leaseAgreement = LeaseAgreement.fromJson(leaseAgreementMap);

      print('\nleaseAgreement: ${leaseAgreement}');
      return leaseAgreement;
    } else {
      _handleError(response);
    }
    return null;
  }

  dynamic findExistingLeaseAgreements(id) async {
    await readFromSecureStorage('myCookie');
    var leaseAgreement = null;

    final response = await http.get(
        Uri.parse('$LEASEAGREEMENTS?tenant=$id&status=1'),
        headers: <String, String>{
          'cookie': cookie,
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBodyJson = json.decode(response.body);
      List<dynamic> leaseAgreements = responseBodyJson['leaseAgreements'];

      if (leaseAgreements.isEmpty) {
        print('No existing lease agreements');
        return null;
      } else {
        print('Active lease agreement found.');
        leaseAgreement = LeaseAgreement.fromJson(jsonDecode(response.body));
        return leaseAgreement;
      }
    } else {
      _handleError(response);
    }
  }

  Future<void> signup(firstName, lastName, email, password) async {
    try {
      final response = await http
          .post(
        Uri.parse(REGISTRATION),
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
      )
          .timeout(Duration(seconds: 7), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      await _returnResponse(response);
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }
  }

  dynamic login(email, password) async {
    var responseJson;

    try {
      final response = await http
          .post(
        Uri.parse(LOGIN),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'password': password,
        }),
      )
          .timeout(Duration(seconds: 7), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }

    return responseJson;
  }

  logout() async {
    await readFromSecureStorage('myCookie');

    try {
      final response = await http.post(
        Uri.parse(LOGOUT),
        headers: <String, String>{
          'cookie': cookie,
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

  Future<User?> loggedInUser() async {
    User? user;

    await readFromSecureStorage('myCookie');
    if (cookie.isEmpty) {
      return null;
    }

    try {
      final response =
          await http.get(Uri.parse(LOGGEDINUSER), headers: <String, String>{
        'cookie': cookie,
        'Content-Type': 'application/json; charset=UTF-8',
      });

      user = await _returnResponse(response);
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }

    return user;
  }

  void _handleError(http.Response response) async {
    Map<String, dynamic> responseBodyJson = {};
    String message = '';
    final statusCode = response.statusCode;

    switch (statusCode) {
      case 400:
        responseBodyJson = json.decode(response.body);
        if (responseBodyJson['detail'] != null) {
          message = responseBodyJson['detail'];
        } else if (responseBodyJson['errors'] != null) {
          Map<String, dynamic> responseErrorsJson = responseBodyJson['errors'];
          responseErrorsJson
              .forEach((i, value) => message += '\n' + value.toString());
        }

        throw BadRequestException(message);
      case 401:
        responseBodyJson = json.decode(response.body);
        if (responseBodyJson['detail'] != null) {
          message = responseBodyJson['detail'];
        }
        throw UnauthorizedException(message);
      default:
        throw Exception('Error occured while Communication with Server with'
            'StatusCode: ${response.statusCode}');
    }
  }

  dynamic _returnResponse(http.Response response) async {
    Map<String, dynamic> responseBodyJson = {};
    String message = '';

    switch (response.statusCode) {
      case 200:
        responseBodyJson = json.decode(response.body);
        var name = responseBodyJson['firstName'];
        var user = null;
        var id = responseBodyJson['id'];

        // obtain shared preferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('name', name);
        prefs.setString('id', id);

        if (response.headers['set-cookie'] != null) {
          String rawCookie = response.headers['set-cookie']!;
          writeToSecureStorage(myKey, rawCookie);
          print('cookie: $rawCookie');
        }

        if (responseBodyJson['roles'].toString().contains("1") &&
            !responseBodyJson['roles'].toString().contains("0")) {
          throw UnauthorizedException("Unable to login");
        }

        user = User.fromJson(jsonDecode(response.body));
        print('User: ${user.id}');

        return user;
      case 201:
        var responseJson = json.decode(response.body.toString());
        print('201-response $responseJson');
        return responseJson;
      case 204:
        writeToSecureStorage(myKey, '');
        cookie = '';
        print('statusCode: 204-response');
        return;
      case 400:
        responseBodyJson = json.decode(response.body);
        if (responseBodyJson['detail'] != null) {
          message = responseBodyJson['detail'];
        } else if (responseBodyJson['errors'] != null) {
          Map<String, dynamic> responseErrorsJson = responseBodyJson['errors'];
          responseErrorsJson
              .forEach((i, value) => message += '\n' + value.toString());
        }

        throw BadRequestException(message);
      case 401:
        responseBodyJson = json.decode(response.body);
        if (responseBodyJson['detail'] != null) {
          message = responseBodyJson['detail'];
        }
        throw UnauthorizedException(message);
      default:
        throw Exception('Error occured while Communication with Server with'
            'StatusCode: ${response.statusCode}');
    }
  }

  Future writeToSecureStorage(myKey, rawCookie) async {
    await storage.write(key: myKey, value: rawCookie);
  }

  Future<void> readFromSecureStorage(myKey) async {
    cookie = (await storage.read(key: myKey))!;
  }
}
