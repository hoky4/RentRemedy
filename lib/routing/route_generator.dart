import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/View/Onboarding/join_screen.dart';
import 'package:rentremedy_mobile/Routing/app_navigation_router.dart';
import 'package:rentremedy_mobile/View/Auth/login_screen.dart';
import 'package:rentremedy_mobile/View/Auth/signup_screen.dart';
import 'package:rentremedy_mobile/View/Chat/message_socket_handler.dart';
import 'package:rentremedy_mobile/View/Onboarding/credit_card_screen.dart';
import 'package:rentremedy_mobile/Old/confirmation_screen.dart';
import 'package:rentremedy_mobile/View/Onboarding/terms_screen.dart';
import 'package:rentremedy_mobile/View/Payment/view_payments_screen.dart';

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
      // }
      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.
      // return _errorRoute();
      case '/creditCard':
        final args = settings.arguments as JoinScreenArguments;
        return MaterialPageRoute(
            builder: (_) =>
                CreditCardScreen(signedLeaseAgreement: args.leaseAgreement));
      case '/viewPayments':
        return MaterialPageRoute(builder: (_) => const ViewPaymentsScreen());

        return _errorRoute();
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
