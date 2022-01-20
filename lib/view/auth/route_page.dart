import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:rentremedy_mobile/view/auth/success_screen.dart';

import 'login_screen.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final ApiService apiService = ApiService();
  bool isLoggedIn = false;
  bool isLoading = false;

  @override
  initState() {
    super.initState();

    setState(() {
      isLoading = true;
    });

    apiService.loggedInUser().then((value) {
      if (value == null) {
        setState(() {
          isLoggedIn = false;
          isLoading = false;
        });
      } else if (value != null) {
        setState(() {
          isLoggedIn = true;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoggedIn = false;
          isLoading = false;
        });
      }
    }).catchError((e) {
      print('Unable to autologin, msg: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isLoggedIn ? SuccessScreen() : LoginScreen(),
        Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: isLoading,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ))
      ],
    );
  }
}
