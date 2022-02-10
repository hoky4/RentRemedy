import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:rentremedy_mobile/view/auth/success_screen.dart';
import 'package:rentremedy_mobile/view/chat/message_socket_handler.dart';

import 'login_screen.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  late ApiService apiService;

  bool isLoggedIn = false;
  bool isLoading = false;

  @override
  initState() {
    super.initState();

    apiService = Provider.of<ApiService>(context, listen: false);

    setState(() {
      isLoading = true;
    });

    fetchLoggedInUser();
    print("done getting logged in user");
  }

  void fetchLoggedInUser() async {
    await apiService.loggedInUser().then((value) {
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
      }
    }).catchError((e) {
      print('Unable to autologin, msg: $e');
    });
    print("fetchLoggedInUser method finished");
  }

  @override
  Widget build(BuildContext context) {
    print('builder called');
    return Stack(
      children: [
        isLoggedIn ? MessageSocketHandler() : LoginScreen(),
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
