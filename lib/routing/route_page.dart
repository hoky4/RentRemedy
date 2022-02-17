import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/providers/api_service_provider.dart';
import 'package:rentremedy_mobile/providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/view/chat/message_socket_handler.dart';
import 'package:rentremedy_mobile/view/onboarding/confirmation_screen.dart';
import 'package:rentremedy_mobile/view/onboarding/terms_screen.dart';
import '../view/auth/login_screen.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  late ApiServiceProvider apiService;
  bool isLoading = true;

  @override
  initState() {
    super.initState();
    apiService = Provider.of<ApiServiceProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      checkForLoggedInUser();
    });
  }

  void checkForLoggedInUser() async {
    var authModel = context.read<AuthModelProvider>();

    if (!authModel.isLoggedIn && authModel.status == AuthStatus.pending) {
      var loggedInUser =
          await apiService.getLoggedInUser(); //Note change to typed
      if (loggedInUser == null) {
        authModel.notLoggedIn();
      } else {
        authModel.loginUser(loggedInUser);
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var authModel = context.watch<AuthModelProvider>();

    if (isLoading) {
      return const CircularProgressIndicator();
    } else if (authModel.isLoggedIn) {
      LeaseAgreement? leaseAgreement = authModel.leaseAgreement;

      if (leaseAgreement != null) {
        if (isSigned(leaseAgreement)) {
          return const MaterialApp(home: MessageSocketHandler());
        } else {
          //ScaffoldMessenger.of(context).showSnackBar(
          //  const SnackBar(content: Text("Lease Agreement not signed yet.")));
          return MaterialApp(home: TermsScreen(leaseAgreement: leaseAgreement));
        }
      } else {
        return const MaterialApp(home: ConfirmationScreen());
      }
    } else {
      return const MaterialApp(
        home: LoginScreen(),
      );
    }
  }

  bool isSigned(LeaseAgreement leaseAgreement) {
    if (leaseAgreement.signatures.isEmpty) {
      print("Existing Lease Agreement NOT signed.");
      return false;
    }
    print("Existing Lease Agreement Signed.");

    return true;
  }
}
