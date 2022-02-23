import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/View/Onboarding/join_screen.dart';
import 'package:rentremedy_mobile/View/Payment/view_payments_screen.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  late bool enabled;

  @override
  final Size preferredSize;

  CustomAppBar({Key? key, required this.title, this.enabled = false})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var authModel = context.read<AuthModelProvider>();

    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      backgroundColor: Colors.blue,
      leading: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {
          authModel.logoutUser();
          Navigator.pushReplacementNamed(context, '/login');
        },
        color: Colors.black,
      ),
      actions: [
        if (authModel.leaseAgreement!.signatures.isEmpty) ...[
          IconButton(
              icon: const Icon(FontAwesome5.hand_paper),
              onPressed: enabled
                  ? () {
                      LeaseAgreement? leaseAgreement = authModel.leaseAgreement;
                      if (leaseAgreement != null) {
                        Navigator.pushNamed(context, '/terms',
                            arguments: JoinScreenArguments(leaseAgreement));
                      }
                    }
                  : null)
        ],
        IconButton(
            icon: const Icon(Icons.comment_rounded),
            onPressed: enabled
                ? () {
                    Navigator.pushReplacementNamed(context, '/chat');
                  }
                : null),
        IconButton(
            icon: const Icon(Icons.attach_money_outlined),
            onPressed: enabled
                ? () {
                    Navigator.pushReplacementNamed(context, '/viewPayments');
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const ViewPaymentsScreen()));
                  }
                : null),
        IconButton(
            icon: const Icon(Icons.build_circle_outlined),
            onPressed: enabled ? () {} : null),
      ],
    );
  }
}
