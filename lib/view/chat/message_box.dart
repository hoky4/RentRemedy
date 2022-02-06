import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/models/Message/message_type.dart';
import 'package:rentremedy_mobile/models/Payments/payment.dart';
import 'package:rentremedy_mobile/networking/api_exception.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:rentremedy_mobile/view/payment/payment_screen.dart';
import 'package:rentremedy_mobile/view/payment/payment_success_screen.dart';
import 'package:rentremedy_mobile/view/payment/view_payment_screen.dart';

class MessageBox extends StatelessWidget {
  final Message message;

  const MessageBox({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String landlordId =
        Provider.of<ApiService>(context, listen: false).landlordId;
    ApiService apiService = Provider.of<ApiService>(context, listen: false);
    String messageBtnText =
        message.type == MessageType.PaymentDue ? 'Pay Now' : 'View Payment';
    Color? messageBtnColor = message.type == MessageType.PaymentDue
        ? Colors.orangeAccent
        : Colors.grey[400];

    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Row(
        mainAxisAlignment: message.sender == landlordId
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          if (message.sender == landlordId) ...[Icon(Icons.person_pin)],
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .6),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue
                  .withOpacity(message.sender != landlordId ? 1 : 0.08),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Text(
                  message.messageText,
                  style: TextStyle(
                      color: message.sender != landlordId
                          ? Colors.white
                          : Theme.of(context).textTheme.bodyText1!.color),
                ),
                if (message.actionId != null) ...[
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(messageBtnColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      Payment payment = await apiService
                          .getPaymentById('${message.actionId}') as Payment;
                      print('payment-id: ${payment.id}');

                      if (message.type == MessageType.PaymentDue) {
                        if (payment.paymentDate == null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PaymentScreen(payment: payment)));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PaymentSuccessScreen()));
                        }
                      } else if (message.type == MessageType.PaymentReceived) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewPaymentScreen(payment: payment)));
                      }
                    },
                    child: Text(messageBtnText,
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  )
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
