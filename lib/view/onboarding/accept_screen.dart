import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/models/User/user.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';

import '../chat/message_screen.dart';

class AcceptScreen extends StatefulWidget {
  late LeaseAgreement leaseAgreement;
  AcceptScreen({Key? key, required this.leaseAgreement}) : super(key: key);

  @override
  _AcceptScreenState createState() => _AcceptScreenState();
}

class _AcceptScreenState extends State<AcceptScreen> {
  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lease Agreeement Details'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(36),
            child: Column(
              children: [
                Container(
                  width: 300,
                  height: 500,
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: SingleChildScrollView(
                      child: Text('${widget.leaseAgreement}')),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await apiService
                        .signLeaseAgreement('${widget.leaseAgreement.id}');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessageScreen()));
                  },
                  child: Text('Accept',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
