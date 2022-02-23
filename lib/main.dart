import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/Providers/message_model_provider.dart';
import 'package:rentremedy_mobile/Routing/route_page.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthModelProvider>(
            create: (context) => AuthModelProvider()),
        ProxyProvider<AuthModelProvider, ApiServiceProvider>(
          create: (context) => ApiServiceProvider(),
          update: (context, authModel, apiService) {
            if (apiService == null)
              throw ArgumentError.notNull('apiService is null');
            apiService.authModelProvider = authModel;
            return apiService;
          },
        ),
        ChangeNotifierProvider<MessageModelProvider>(
            create: (context) => MessageModelProvider())
      ],
      child: const RoutePage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
