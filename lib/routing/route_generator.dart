import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/routing/app_navigation_router.dart';
import 'package:rentremedy_mobile/view/auth/login_screen.dart';
import 'package:rentremedy_mobile/view/auth/signup_screen.dart';
import 'package:rentremedy_mobile/view/chat/message_socket_handler.dart';
import 'package:rentremedy_mobile/view/onboarding/confirmation_screen.dart';
import 'package:rentremedy_mobile/view/onboarding/join_screen.dart';
import 'package:rentremedy_mobile/view/onboarding/terms_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const AppNavigationRouter());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case '/confirmation':
        return MaterialPageRoute(builder: (_) => const ConfirmationScreen());
      case '/join':
        final args = settings.arguments as JoinScreenArguments;
        return MaterialPageRoute(
            builder: (_) => JoinScreen(leaseAgreement: args.leaseAgreement));
      case '/terms':
        final args = settings.arguments as JoinScreenArguments;
        return MaterialPageRoute(
            builder: (_) => TermsScreen(leaseAgreement: args.leaseAgreement));
      case '/chat':
        return MaterialPageRoute(builder: (_) => const MessageSocketHandler());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('No such named route'),
        ),
      );
    });
  }
}
