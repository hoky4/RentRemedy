import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/view/auth/login_screen.dart';
import 'package:rentremedy_mobile/routing/route_page.dart';
import 'package:rentremedy_mobile/view/chat/message_socket_handler.dart';
import 'package:rentremedy_mobile/view/onboarding/credit_card_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const RoutePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/chat':
        // Validation of correct data type
        // if (args is String) {
        return MaterialPageRoute(builder: (_) => const MessageSocketHandler());
      // }
      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.
      // return _errorRoute();
      case '/creditCard':
        return MaterialPageRoute(builder: (_) => const CreditCardScreen());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('No such named route'),
        ),
      );
    });
  }
}
