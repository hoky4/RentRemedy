import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/providers/api_service_provider.dart';
import 'package:rentremedy_mobile/providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/routing/route_generator.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  late ApiServiceProvider apiService;

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

    if (authModel.status == AuthStatus.pending) {
      var loggedInUser =
          await apiService.getLoggedInUser(); //Note change to typed

      if (loggedInUser == null) {
        authModel.notLoggedIn();
      } else {
        authModel.loginUser(loggedInUser);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Rent Remedy',
      initialRoute: '/login',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
