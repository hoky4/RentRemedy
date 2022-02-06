import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Payments/payment.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:rentremedy_mobile/view/payment/payment_success_screen.dart';

class ViewPaymentScreen extends StatelessWidget {
  Payment payment;
  ViewPaymentScreen({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("View Payment"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    balanceInfo(),
                    Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                  ],
                ),
              ),
            ),
            // acceptButton(context, payment.id),
            // SizedBox(height: 8.0)
          ],
        ),
      ),
    );
  }

  Widget balanceInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 200.0, 0, 0),
      child: Align(
        // alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Balance Paid", style: categoryStyle),
            SizedBox(height: 16.0),
            Text("Paid Amount: \$${payment.getDollarAmount}", style: bodyStyle),
            // if (payment.isLate == true) ...[
            //   Text("Late Fee: \$${payment.lateFee}", style: bodyStyle)
            //   ],
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Paid Date: ", style: bodyStyle),
                Text("${DateFormat.yMMMMd('en_US').format(payment.dueDate)}",
                    style: bodyStyle),
              ],
            )
          ],
        ),
      ),
    );
  }
}

TextStyle categoryStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400, fontSize: 24, color: Colors.black);

TextStyle bodyStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black);
