import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/View/Onboarding/join_screen.dart';
import 'package:rentremedy_mobile/View/Payment/view_payments_screen.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  @override
  final Size preferredSize;

  CustomAppBar(
    this.title, {
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var authModel = context.read<AuthModelProvider>();

    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          // IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authModel.logoutUser();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          Text(title)
        ],
      ),
      backgroundColor: Colors.blue,
      // leading: IconButton(
      //   icon: Icon(Icons.chevron_left),
      //   onPressed: () => Navigator.pop(context),
      //   color: Colors.black,
      // ),
      actions: [
        if (authModel.leaseAgreement!.signatures.isEmpty) ...[
          IconButton(
              icon: const Icon(FontAwesome5.hand_paper),
              onPressed: () {
                LeaseAgreement? leaseAgreement = authModel.leaseAgreement;
                if (leaseAgreement != null) {
                  Navigator.pushReplacementNamed(context, '/terms',
                      arguments: JoinScreenArguments(leaseAgreement));
                }
              })
        ],
        IconButton(
            icon: const Icon(Icons.comment_rounded),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/chat');
            }),
        IconButton(
            icon: const Icon(Icons.attach_money_outlined),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/viewPayments');
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const ViewPaymentsScreen()));
            }),
        IconButton(
            icon: const Icon(Icons.build_circle_outlined), onPressed: () {}),
      ],
    );
  }
}
