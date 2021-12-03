import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:rentremedy_mobile/view/success_screen.dart';

import 'login.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final ApiService apiService = ApiService();
  bool isLoggedIn = false;

  @override
  initState() {
    super.initState();
    apiService.loggedInUser().then((value) {
      if (value == null) {
        setState(() {
          isLoggedIn = false;
        });
      } else if (value != null) {
        setState(() {
          isLoggedIn = true;
        });
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    }).catchError((e) {
      print('Unable to autologin, msg: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? SuccessScreen() : Login();
  }
}
