import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/providers/api_service_provider.dart';
import 'package:rentremedy_mobile/providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/providers/message_model_provider.dart';
import 'package:rentremedy_mobile/routing/route_generator.dart';

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
            if (apiService == null) throw ArgumentError.notNull('apiService');
            apiService.authModelProvider = authModel;
            return apiService;
          },
        ),
        ChangeNotifierProvider<MessageModelProvider>(
            create: (context) => MessageModelProvider())
      ],
      // child: const CardScreen(),
      child: const MaterialApp(
        // Initially display FirstPage
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
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
