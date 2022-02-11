import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:rentremedy_mobile/models/Auth/logged_in_user.dart';
import 'package:rentremedy_mobile/networking/api.dart';
import 'package:rentremedy_mobile/networking/api_exception.dart';
import 'package:rentremedy_mobile/providers/auth_model_provider.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  late AuthModelProvider _authModelProvider;

  AuthModelProvider get authModelProvider => _authModelProvider;

  set authModelProvider(AuthModelProvider authModelProvider) {
    _authModelProvider = authModelProvider;
  }

  dynamic login(email, password) async {
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
          .timeout(Duration(seconds: 15), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        LoggedInUser user = LoggedInUser.fromJson(responseMap);

        // prevent landlord from logging in to the app
        if (user.roles.toString().contains("1") &&
            !user.roles.toString().contains("0")) {
          throw UnauthorizedException("Unable to login");
        }

        // store cookie
        if (response.headers['set-cookie'] != null) {
          user.cookie = response.headers['set-cookie']!;
        }

        return user;
      } else {
        return _handleError(response);
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }
  

  dynamic getLoggedInUser() async {
    if (_authModelProvider.cookie != null) {
      return null;
    }

    try {
      final response =
          await http.get(Uri.parse(LOGGEDINUSER), headers: <String, String>{
        'cookie': _authModelProvider.cookie!,
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        LoggedInUser user = LoggedInUser.fromJson(responseMap);

        // store cookie
        if (response.headers['set-cookie'] != null) {
          user.cookie = response.headers['set-cookie']!;
        }

        return user;
      } else {
        return _handleError(response);
      }
    } on SocketException {
      throw Exception('No Internet connection');
    }
  }

  dynamic _handleError(http.Response response) async {
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
      case 403:
        responseBodyJson = json.decode(response.body);
        if (responseBodyJson['detail'] != null) {
          message = responseBodyJson['detail'];
        }
        throw ForbiddenException(message);
      default:
        throw Exception('Error occured while Communication with Server with'
            'StatusCode: ${response.statusCode}');
    }
  }
}
