import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/View/onboarding/join_screen.dart';

class AppNavigationRouter extends StatefulWidget {
  const AppNavigationRouter({Key? key}) : super(key: key);

  @override
  _AppNavigationRouterState createState() => _AppNavigationRouterState();
}

class _AppNavigationRouterState extends State<AppNavigationRouter> {
  @override
  initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      checkForNavigationEvent();
    });
  }

  void checkForNavigationEvent() async {
    var authModel = context.read<AuthModelProvider>();

    if (authModel.status == AuthStatus.loggedIn) {
      LeaseAgreement? leaseAgreement = authModel.leaseAgreement;

      if (leaseAgreement != null) {
        if (isSigned(leaseAgreement)) {
          Navigator.pushReplacementNamed(context, '/chat');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Lease Agreement Not Signed Yet")));
          Navigator.pushReplacementNamed(context, '/terms',
              arguments: JoinScreenArguments(leaseAgreement));
        }
      } else {
        Navigator.pushReplacementNamed(context, '/confirmation');
      }
    } else if (authModel.status == AuthStatus.notLoggedIn) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CircularProgressIndicator());
  }

  bool isSigned(LeaseAgreement leaseAgreement) {
    if (leaseAgreement.signatures.isEmpty) {
      return false;
    }

    return true;
  }
}
