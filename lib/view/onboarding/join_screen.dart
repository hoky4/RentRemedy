import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/networking/api_exception.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:rentremedy_mobile/view/onboarding/terms_screen.dart';

import 'accept_screen.dart';
import 'confirmation_screen.dart';

class JoinScreen extends StatelessWidget {
  late LeaseAgreement leaseAgreement;
  JoinScreen({Key? key, required this.leaseAgreement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Join Property'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Text('Is this the right property?'),
                  propertyDetail(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      noButton(context),
                      SizedBox(width: 8),
                      yesButton(apiService, context),
                    ],
                  )
                ],
              ))),
    );
  }

  Widget yesButton(ApiService apiService, BuildContext context) {
    return TextButton(
      onPressed: () async {
        try {
          await apiService.joinLeaseAgreement('${leaseAgreement.id}');
          if (leaseAgreement.property != null) {
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (context) => TermsScreen(
                          leaseAgreement: leaseAgreement,
                        )));
          }
        } on ForbiddenException catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${e.toString()}")));
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (context) => ConfirmationScreen()));
        }
      },
      child: Text(
        'Yes',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget noButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => ConfirmationScreen()));
      },
      child: Text(
        'No',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget propertyDetail() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          propertyDetailLine('description: ', '${leaseAgreement.description}'),
          SizedBox(height: 8),
          propertyDetailLine('landlord: ',
              '${leaseAgreement.landlord.firstName.toUpperCase()} ${leaseAgreement.landlord.lastName.toUpperCase()}'),
        ],
      ),
    );
  }

  Widget propertyDetailLine(String title, String detail) {
    return Row(
      children: [
        Text("$title",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        Text("$detail"),
      ],
    );
  }
}
