import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/status.dart';
import 'package:rentremedy_mobile/Model/Message/message.dart';
import 'package:rentremedy_mobile/Model/Message/create_message_request.dart';
import 'package:rentremedy_mobile/Model/Message/messaging_socket_response.dart';
import 'package:rentremedy_mobile/Model/Payments/payment.dart';
import 'package:rentremedy_mobile/Model/Payments/payment_intent_response.dart';
import 'package:rentremedy_mobile/Model/Payments/setup_intent_response.dart';
import 'package:rentremedy_mobile/Model/User/user.dart';
import 'package:rentremedy_mobile/networking/api.dart';
import 'package:rentremedy_mobile/networking/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ApiService {
  /*
  dynamic makePaymentIntent(String id) async {
    var result;

    final response = await http.post(Uri.parse('$PAYMENT/payment-intent'),
        headers: <String, String>{
          'cookie': cookie,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'paymentId': id,
        }));

    if (response.statusCode == 200) {
      // print('resp-paid-balance: ${response.body}');

      Map<String, dynamic> responseMap = jsonDecode(response.body);
      PaymentIntentResponse payment =
          PaymentIntentResponse.fromJson(responseMap);
      // print('payment-intent-payment-paid-date: ${payment.payment.paymentDate}');
      // print('payment-intent-payment-status: ${payment.status}');
      return payment;
    } else {
      result = _handleError(response);
    }
    return result;
  }*/

  /*
  dynamic makeSetupIntent() async {
    var result;

    final response = await http.post(Uri.parse('$PAYMENT/setup-intent'),
        headers: <String, String>{
          'cookie': cookie,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "type": "card",
          "number": "4242424242424242",
          "expMonth": 7,
          "expYear": 2025,
          "cvc": "333"
        }));

    if (response.statusCode == 200) {
      // print('resp-setup-intent: ${response.body}');

      Map<String, dynamic> responseMap = jsonDecode(response.body);
      SetupIntentResponse setupIntentResponse =
          SetupIntentResponse.fromJson(responseMap);
      // print('setup-intent-status: ${setupIntentResponse.status}');
      return setupIntentResponse;
    } else {
      result = _handleError(response);
    }
    return result;
  }*/

  /*
  dynamic getPaymentById(String id) async {
    var result;

    final response = await http.get(
      Uri.parse('$PAYMENT/$id'),
      headers: <String, String>{
        'cookie': cookie,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // print('resp-payment: ${response.body}');

      Map<String, dynamic> responseMap = jsonDecode(response.body);
      Payment payment = Payment.fromJson(responseMap);
      return payment;
    } else {
      result = _handleError(response);
    }
    return result;
  }*/

  /*
  Message parseInboundMessageFromSocket(String inboundMessage) {
    Map<String, dynamic> responseMap = jsonDecode(inboundMessage);
    Message message = Message.fromJson(responseMap);
    return message;
  }*/

  /*
  Future<List<Message>> getConversation() async {
    var result;
    if (landlordId.isEmpty) {
      landlordId = await getLandlordId();
    }

    print('landlord-id: $landlordId');
    if (cookie.isEmpty) {
      print('\ncookie is empty');
      await readFromSecureStorage('myCookie');
    }

    final response = await http.get(
      Uri.parse('$CONVERSATION/$landlordId'),
      headers: <String, String>{
        'cookie': cookie,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // print('resp-convo: ${response.body}');
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      List<dynamic> conversationListDynamic = responseMap['conversation'];

      List<Message> conversationList = List<Message>.from(
          conversationListDynamic.map((i) => Message.fromJson(i)));
      // messageModel.messages = conversationList;
      return conversationList;
    } else {
      result = _handleError(response);
    }

    return result;
  }*/

  /*
  dynamic signLeaseAgreement(id) async {
    await readFromSecureStorage('myCookie');
    var responseJson;

    final response = await http.post(
      Uri.parse('$LEASEAGREEMENTS/$id/signatures'),
      headers: <String, String>{
        'cookie': cookie,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{}),
    );

    if (response.statusCode == 200) {
      print('\nresponse: ${response.body}');
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      var leaseAgreement = LeaseAgreement.fromJson(responseMap);

      // obtain shared preferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('landlordId', leaseAgreement.landlord.id);
      landlordId = leaseAgreement.landlord.id;
      print('Saved landlordId: ${leaseAgreement.landlord.id}');
      landlordId = leaseAgreement.landlord.id;

      return leaseAgreement;
    } else {
      responseJson = _handleError(response);
    }

    return responseJson;
  }*/

  /*
  dynamic joinLeaseAgreement(id) async {
    var responseJson;
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
      responseJson = _handleError(response);
    }
    return responseJson;
  }*/

  /*
  Future<LeaseAgreement?> getLeaseAgreement(shortId) async {
    await readFromSecureStorage('myCookie');

    final response = await http.get(Uri.parse('$LEASEAGREEMENTS?code=$shortId'),
        headers: <String, String>{
          'cookie': cookie,
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      print('\nget-la-response: ${response.body}');
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      List<dynamic> leaseAgreements = responseMap['leaseAgreements'];
      if (leaseAgreements.isEmpty) {
        throw NotFoundException("No Results Found");
      }

      Map<String, dynamic> leaseAgreementMap =
          responseMap['leaseAgreements'][0];
      var leaseAgreement = LeaseAgreement.fromJson(leaseAgreementMap);
      print('la-status: ${leaseAgreement.status}');
      return leaseAgreement;
    } else {
      _handleError(response);
    }
    return null;
  }*/

  /*
  dynamic findExistingLeaseAgreements(id) async {
    await readFromSecureStorage('myCookie');
    var leaseAgreement = null;

    final response = await http.get(
        // Uri.parse('$LEASEAGREEMENTS?tenant=$id&status=AssignedSigned'),
        Uri.parse('$LEASEAGREEMENTS?tenant=$id'),
        headers: <String, String>{
          'cookie': cookie,
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      List<dynamic> leaseAgreements = responseMap['leaseAgreements'];

      if (leaseAgreements.isEmpty) {
        print('No existing lease agreements found.');
        return null;
      } else {
        print('Active lease agreement found.');

        List<LeaseAgreement> leaseAgreementList = List<LeaseAgreement>.from(
            leaseAgreements.map((i) => LeaseAgreement.fromJson(i)));

        List<LeaseAgreement> signedLeaseAgreements = leaseAgreementList
            .where((i) => (i.status == Status.AssignedUnsigned ||
                i.status == Status.AssignedSigned))
            .toList();
        // leaseAgreement = LeaseAgreement.fromJson(leaseAgreements[0]);
        leaseAgreement = signedLeaseAgreements.first;
        return leaseAgreement;
      }
    } else {
      _handleError(response);
    }
  }*/

  /*
  dynamic signup(firstName, lastName, email, password) async {
    var responseJson;

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
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      if (response.statusCode == 201) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        print('201-response $responseMap');
        // return responseMap;
      } else {
        responseJson = _handleError(response);
      }
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }
    return responseJson;
  }*/

  /*
  dynamic logout() async {
    var responseJson;

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

      if (response.statusCode == 204) {
        writeToSecureStorage(myKey, '');
        cookie = '';
        print('statusCode: 204-response');
      } else {
        responseJson = _handleError(response);
      }
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }

    return responseJson;
  }
  */

  /*
  dynamic loggedInUser() async {
    await readFromSecureStorage('myCookie');
    if (cookie.isEmpty) {
      print('No existing cookie found.');
      return null;
    }

    try {
      final response =
          await http.get(Uri.parse(LOGGEDINUSER), headers: <String, String>{
        'cookie': cookie,
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        User user = User.fromJson(responseMap);
        return user;
      } else {
        return _handleError(response);
      }
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }
  }*/

  /*
  dynamic _handleError(http.Response response) async {
    Map<String, dynamic> responseBodyJson = {};
    String message = '';
    final statusCode = response.statusCode;
    print('statusCode: $statusCode');

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
  }*/

  /*
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
          .timeout(Duration(seconds: 15), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        User user = User.fromJson(responseMap);

        // obtain shared preferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('name', user.firstName);
        prefs.setString('id', user.id);

        // store cookie
        if (response.headers['set-cookie'] != null) {
          String rawCookie = response.headers['set-cookie']!;
          writeToSecureStorage(myKey, rawCookie);
          print('Stored cookie: $rawCookie');
        }

        // prevent landlord from logging in to the app
        if (user.roles.toString().contains("1") &&
            !user.roles.toString().contains("0")) {
          throw UnauthorizedException("Unable to login");
        }

        return user;
      } else {
        responseJson = _handleError(response);
      }
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }

    return responseJson;
  }*/

  // Future writeToSecureStorage(myKey, rawCookie) async {
  //   await storage.write(key: myKey, value: rawCookie);
  // }

  // Future<void> readFromSecureStorage(myKey) async {
  //   cookie = (await storage.read(key: myKey))!;
  // }

  // Future<String> getUserId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final id = (prefs.getString('id') ?? '');
  //   return id;
  // }

  // Future<String> getLandlordId() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final id = (prefs.getString('landlordId') ?? '');

  //   return id;
  // }
}
