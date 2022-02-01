import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                  Text("Is this the right property?",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                  propertyDetail(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      noButton(context),
                      SizedBox(width: 8),
                      yesButton(context),
                    ],
                  )
                ],
              ))),
    );
  }

  Widget yesButton(BuildContext context) {
    ApiService apiService = Provider.of<ApiService>(context, listen: false);

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
          propertyDetailLine('Description: ', '${leaseAgreement.description}'),
          SizedBox(height: 8),
          propertyDetailLine(
              'Address: ', '${leaseAgreement.property.toString()}'),
          SizedBox(height: 8),
          propertyDetailLine('Landlord: ',
              '${leaseAgreement.landlord.firstName.capitalize()} ${leaseAgreement.landlord.lastName.capitalize()}'),
        ],
      ),
    );
  }

  Widget propertyDetailLine(String title, String detail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text("$title",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        Flexible(child: Text("$detail")),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
