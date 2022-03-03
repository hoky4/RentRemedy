import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rentremedy_mobile/Model/Payments/payment.dart';

class ViewPaymentScreenArguments {
  final Payment payment;

  ViewPaymentScreenArguments(this.payment);
}

class ViewPaymentScreen extends StatelessWidget {
  Payment payment;
  ViewPaymentScreen({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("View Payment"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    balanceInfo(),
                    const Divider(
                        thickness: 1, indent: 32, endIndent: 32, height: 48),
                  ],
                ),
              ),
            ), // SizedBox(height: 8.0)
          ],
        ),
      ),
    );
  }

  Widget balanceInfo() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 200.0, 0, 0),
      child: Align(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Balance Paid", style: categoryStyle),
            const SizedBox(height: 16.0),
            paymentDetailLine(
                "Paid Amount: ", '\$${convertToDollar(payment.chargeAmount)}'),
            paymentDetailLine("Paid Date: ",
                DateFormat.yMMMMd('en_US').format(payment.dueDate))
          ],
        ),
      ),
    );
  }

  String convertToDollar(amount) {
    final value = amount / 100;
    final money = NumberFormat("###,###,###", "en_us");
    return money.format(value);
  }

  Widget paymentDetailLine(String title, String detail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(title, style: bodyStyleBold),
        Flexible(child: Text(detail, style: bodyStyle)),
      ],
    );
  }
}

TextStyle categoryStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400, fontSize: 24, color: Colors.black);

TextStyle bodyStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black);

TextStyle bodyStyleBold = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black);
