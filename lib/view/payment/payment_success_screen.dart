import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/view/chat/message_screen.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({Key? key}) : super(key: key);

  @override
  _PaymentSuccessScreenState createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Your payment was done successfully"),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.lightGreenAccent,
              fixedSize: const Size(200, 72),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),

          // ButtonStyle(
          //   backgroundColor: MaterialStateProperty.all(Colors.green),
          //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //     RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(24.0),
          //     ),
          //   ),
          // ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => MessageScreen()));
          },
          child: Text('Done',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w400)),
        )
      ],
    ));
  }
}
