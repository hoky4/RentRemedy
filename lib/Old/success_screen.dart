import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../View/Auth/login_screen.dart';

class SuccessScreen extends StatefulWidget {
  SuccessScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  String _name = '';
  // ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  void _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = (prefs.getString('name') ?? '');
      print('name: $_name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Successfully Logged in'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                // await apiService.logout();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
            )
          ],
        ),
        body: Center(child: Text('Welcome, $_name!')));
  }
}
