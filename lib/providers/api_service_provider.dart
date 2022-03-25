import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:rentremedy_mobile/Model/Auth/logged_in_user.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/status.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/terminate_lease_agreement_request.dart';
import 'package:rentremedy_mobile/Model/Maintenance/maintenance_request_request.dart';
import 'package:rentremedy_mobile/Model/Maintenance/maintenance_request.dart';
import 'package:rentremedy_mobile/Model/Maintenance/severity_type.dart';
import 'package:rentremedy_mobile/Model/Message/message.dart';
import 'package:rentremedy_mobile/Model/Payments/payment.dart';
import 'package:rentremedy_mobile/Model/Payments/payment_intent_response.dart';
import 'package:rentremedy_mobile/Model/Payments/setup_intent_request.dart';
import 'package:rentremedy_mobile/Model/Payments/setup_intent_response.dart';
import 'package:rentremedy_mobile/Model/Property/address.dart';
import 'package:rentremedy_mobile/Model/environment.dart';
import 'package:rentremedy_mobile/Networking/api.dart';
import 'package:rentremedy_mobile/Networking/api_exception.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  late AuthModelProvider _authModelProvider;

  AuthModelProvider get authModelProvider => _authModelProvider;

  set authModelProvider(AuthModelProvider authModelProvider) {
    _authModelProvider = authModelProvider;
  }

  dynamic terminateLeaseAgreement(String id, String reason, String line1,
      String line2, String city, String state, String zipCode) async {
    Address newAddress =
        Address(line1, line2, city, state, zipCode, "Section A");
    final now = DateTime.now();
    final nowPlusOneMonth = DateTime(now.year, now.month + 1, now.day, now.hour,
        now.minute, now.second, now.millisecond, now.microsecond);
    final nowIsoStr = nowPlusOneMonth.toIso8601String();

    TerminateLeaseAgreementRequest request =
        TerminateLeaseAgreementRequest(nowIsoStr, reason, newAddress);
    final response = await http.post(
      Uri.parse('${Environment.apiUrl}$LEASEAGREEMENTS/$id/terminate'),
      headers: <String, String>{
        'cookie': _authModelProvider.cookie!,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      LeaseAgreement leaseAgreement = LeaseAgreement.fromJson(responseMap);

      return leaseAgreement;
    } else {
      return _handleError(response);
    }
  }

  dynamic getMaintenanceRequest(String id) async {
    final response = await http.get(
      Uri.parse('${Environment.apiUrl}$MAINTENANCE/$id'),
      headers: <String, String>{
        'cookie': _authModelProvider.cookie!,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      MaintenanceRequest request = MaintenanceRequest.fromJson(responseMap);
      return request;
    } else {
      return _handleError(response);
    }
  }

  dynamic getAllMaintenanceRequests() async {
    final response = await http.get(
      Uri.parse(Environment.apiUrl + MAINTENANCE),
      headers: <String, String>{
        'cookie': _authModelProvider.cookie!,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      List<dynamic> maintenanceRequests = responseMap['maintenanceRequests'];

      List<MaintenanceRequest> maintenanceRequestList =
          List<MaintenanceRequest>.from(
              maintenanceRequests.map((i) => MaintenanceRequest.fromJson(i)));

      return maintenanceRequestList;
      // }
    } else {
      return _handleError(response);
    }
  }

  dynamic createMaintenanceRequest(String item, String location,
      String description, SeverityType severity) async {
    // User user = User(
    //     _authModelProvider.user!.id,
    //     _authModelProvider.user!.firstName,
    //     _authModelProvider.user!.lastName,
    //     _authModelProvider.user!.email);
    MaintenanceRequestRequest request = MaintenanceRequestRequest(
        // user,
        _authModelProvider.leaseAgreement!.id,
        _authModelProvider.leaseAgreement!.property!.id,
        severity,
        item,
        location,
        description,
        null);
    final response =
        await http.post(Uri.parse(Environment.apiUrl + MAINTENANCE),
            headers: <String, String>{
              'cookie': _authModelProvider.cookie!,
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(request.toJson()));

    if (response.statusCode == 201) {
      print("status 201......");
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      MaintenanceRequest maintenanceRequest =
          MaintenanceRequest.fromJson(responseMap);
      return maintenanceRequest;
    } else {
      return _handleError(response);
    }
  }

  dynamic makePaymentIntent(String id) async {
    final response = await http.post(
        Uri.parse('${Environment.apiUrl}$PAYMENT/payment-intent'),
        headers: <String, String>{
          'cookie': _authModelProvider.cookie!,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'paymentId': id,
        }));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      PaymentIntentResponse payment =
          PaymentIntentResponse.fromJson(responseMap);
      return payment;
    } else {
      return _handleError(response);
    }
  }

  dynamic makeSetupIntent(
      String number, String expiryDate, String cvv, String cardHolder) async {
    String cardNumber = number.replaceAll(' ', '');
    List<String> expiryDateArr = expiryDate.split('/');
    int expiryMonth = int.parse(expiryDateArr[0]);
    int expiryYear = int.parse('20' + expiryDateArr[1]);

    SetupIntentRequest request =
        SetupIntentRequest('card', cardNumber, expiryMonth, expiryYear, cvv);

    final response =
        await http.post(Uri.parse('${Environment.apiUrl}$PAYMENT/setup-intent'),
            headers: <String, String>{
              'cookie': _authModelProvider.cookie!,
              'Content-Type': 'application/json',
            },
            body: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      SetupIntentResponse setupIntentResponse =
          SetupIntentResponse.fromJson(responseMap);
      return setupIntentResponse;
    } else {
      return _handleError(response);
    }
  }

  dynamic getAllPayments() async {
    final response = await http.get(
      Uri.parse(Environment.apiUrl + PAYMENT),
      headers: <String, String>{
        'cookie': _authModelProvider.cookie!,
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      List<dynamic> payments = responseMap['payments'];

      List<Payment> paymentList =
          List<Payment>.from(payments.map((i) => Payment.fromJson(i)));

      return paymentList;
    } else {
      return _handleError(response);
    }
  }

  dynamic getPaymentById(String id) async {
    final response = await http.get(
      Uri.parse('${Environment.apiUrl}$PAYMENT/$id'),
      headers: <String, String>{
        'cookie': _authModelProvider.cookie!,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      Payment payment = Payment.fromJson(responseMap);
      return payment;
    } else {
      return _handleError(response);
    }
  }

  Message parseInboundMessageFromSocket(String inboundMessage) {
    Map<String, dynamic> responseMap = jsonDecode(inboundMessage);
    Message message = Message.fromJson(responseMap);
    return message;
  }

  Future<List<Message>> getConversation() async {
    String? landlordId = _authModelProvider.landlordId;

    if (landlordId != null) {
      final response = await http.get(
        Uri.parse('${Environment.apiUrl}$CONVERSATION/$landlordId'),
        headers: <String, String>{
          'cookie': _authModelProvider.cookie!,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        List<dynamic> conversationListDynamic = responseMap['conversation'];
        List<Message> conversationList = List<Message>.from(
            conversationListDynamic.map((i) => Message.fromJson(i)));
        return conversationList;
      } else {
        return _handleError(response);
      }
    }
    return [];
  }

  dynamic signLeaseAgreement(id) async {
    final response = await http.post(
      Uri.parse('${Environment.apiUrl}$LEASEAGREEMENTS/$id/signatures'),
      headers: <String, String>{
        'cookie': _authModelProvider.cookie!,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      LeaseAgreement leaseAgreement = LeaseAgreement.fromJson(responseMap);

      return leaseAgreement;
    } else {
      return _handleError(response);
    }
  }

  dynamic joinLeaseAgreement(id) async {
    final response = await http.post(
      Uri.parse('${Environment.apiUrl}$LEASEAGREEMENTS/$id/join'),
      headers: <String, String>{
        'cookie': _authModelProvider.cookie!,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{}),
    );

    if (response.statusCode == 200) {
      print("Joined LA: $id");
      return;
    } else {
      return _handleError(response);
    }
  }

  Future<LeaseAgreement?> getLeaseAgreement(shortId) async {
    final response = await http.get(
        Uri.parse('${Environment.apiUrl}$LEASEAGREEMENTS?code=$shortId'),
        headers: <String, String>{
          'cookie': _authModelProvider.cookie!,
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      print("LA-resp: ${response.body}");
      Map<String, dynamic> responseMap = jsonDecode(response.body);

      List<dynamic> leaseAgreements = responseMap['leaseAgreements'];
      if (leaseAgreements.isEmpty) {
        throw NotFoundException("No Results Found");
      }

      Map<String, dynamic> leaseAgreementMap =
          responseMap['leaseAgreements'][0];
      LeaseAgreement leaseAgreement =
          LeaseAgreement.fromJson(leaseAgreementMap);
      return leaseAgreement;
    } else {
      return _handleError(response);
    }
  }

  Future<LeaseAgreement?> findExistingLeaseAgreements(LoggedInUser user) async {
    LeaseAgreement leaseAgreement;

    final response = await http.get(
        Uri.parse('${Environment.apiUrl}$LEASEAGREEMENTS?tenant=${user.id}'),
        headers: <String, String>{
          'cookie': user.cookie!,
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
        leaseAgreement = signedLeaseAgreements.first;
        return leaseAgreement;
      }
    } else {
      return _handleError(response);
    }
  }

  dynamic findAllLeaseAgreements() async {
    final response = await http.get(
        Uri.parse(
            '${Environment.apiUrl}$LEASEAGREEMENTS?tenant=${authModelProvider.user!.id}'),
        headers: <String, String>{
          'cookie': authModelProvider.user!.cookie!,
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseMap = json.decode(response.body);
      List<dynamic> leaseAgreements = responseMap['leaseAgreements'];

      List<LeaseAgreement> leaseAgreementList = List<LeaseAgreement>.from(
          leaseAgreements.map((i) => LeaseAgreement.fromJson(i)));

      return leaseAgreementList;
    } else {
      return _handleError(response);
    }
  }

  dynamic signup(firstName, lastName, email, password) async {
    // User user = User(firstName, lastName, email, password, [Role.Tenant]);
    try {
      final response = await http
          .post(
        Uri.parse(Environment.apiUrl + USERS),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // body: jsonEncode(user.toJson()),
        body: jsonEncode(<String, dynamic>{
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'roles': [0]
        }),
      )
          .timeout(const Duration(seconds: 15), onTimeout: () {
        throw TimeoutException(
            'The connection has timed out, Please try again!');
      });

      if (response.statusCode == 201) {
        print('User Successfully Signed Up');
      } else {
        return _handleError(response);
      }
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }
  }

  dynamic login(email, password) async {
    try {
      final response = await http
          .post(
        Uri.parse(Environment.apiUrl + LOGIN),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'password': password,
        }),
      )
          .timeout(const Duration(seconds: 15), onTimeout: () {
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

        // set cookie
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
    if (_authModelProvider.cookie == null) {
      return null;
    }

    try {
      final response = await http.get(
          Uri.parse(Environment.apiUrl + LOGGEDINUSER),
          headers: <String, String>{
            'cookie': _authModelProvider.cookie!,
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        LoggedInUser user = LoggedInUser.fromJson(responseMap);

        // set cookie
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

  dynamic logout() async {
    try {
      final response = await http.post(
        Uri.parse(Environment.apiUrl + LOGOUT),
        headers: <String, String>{
          'cookie': _authModelProvider.cookie!,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{}),
      );

      if (response.statusCode == 204) {
        print('User has successfully logged out');
      } else {
        return _handleError(response);
      }
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }
  }

  dynamic _handleError(http.Response response) async {
    Map<String, dynamic> responseBodyJson = {};
    String message = '';
    final statusCode = response.statusCode;
    print('status Code: $statusCode');
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
