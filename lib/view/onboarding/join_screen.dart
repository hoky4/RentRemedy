import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/networking/api_exception.dart';
import 'package:rentremedy_mobile/providers/api_service_provider.dart';
import 'package:rentremedy_mobile/view/onboarding/terms_screen.dart';
import 'confirmation_screen.dart';

class JoinScreen extends StatelessWidget {
  late LeaseAgreement leaseAgreement;

  JoinScreen({Key? key, required this.leaseAgreement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Property'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  const Text("Is this the right property?",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
                  propertyDetail(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      noButton(context),
                      const SizedBox(width: 8),
                      yesButton(context),
                    ],
                  )
                ],
              ))),
    );
  }

  Widget yesButton(BuildContext context) {
    ApiServiceProvider apiService =
        Provider.of<ApiServiceProvider>(context, listen: false);

    return TextButton(
      onPressed: () async {
        try {
          await apiService.joinLeaseAgreement(leaseAgreement.id);
          if (leaseAgreement.property != null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TermsScreen(
                          leaseAgreement: leaseAgreement,
                        )));
          }
        } on ForbiddenException catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ConfirmationScreen()));
        }
      },
      child: const Text(
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
        // Navigator.pop(context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ConfirmationScreen()));
      },
      child: const Text(
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
          propertyDetailLine('Description: ', leaseAgreement.description),
          const SizedBox(height: 8),
          propertyDetailLine('Address: ', leaseAgreement.property.toString()),
          const SizedBox(height: 8),
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
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black)),
        Flexible(child: Text(detail)),
      ],
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
