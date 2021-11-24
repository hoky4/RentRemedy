import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Successfully Logged in'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {},
            )
          ],
        ),
        body: Text('Welcome!'));
  }
}
