import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Message/message.dart';
import 'package:rentremedy_mobile/Model/Message/message_type.dart';
import 'package:rentremedy_mobile/Model/Payments/payment.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/View/payment/payment_screen.dart';
import 'package:rentremedy_mobile/View/payment/view_payment_screen.dart';

class MessageBox extends StatelessWidget {
  final Message message;

  const MessageBox({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String? landlordId = context.read<AuthModelProvider>().landlordId;

    ApiServiceProvider apiService =
        Provider.of<ApiServiceProvider>(context, listen: false);
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
          if (message.sender == landlordId) ...[const Icon(Icons.person_pin)],
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .6),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: message.sender != landlordId
                  ? Colors.blue
                  : Theme.of(context).primaryColorDark.withOpacity(0.80),
              //color: Colors.blue
              //  .withOpacity(message.sender != landlordId ? 1 : 0.08),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Text(
                  message.messageText,
                  style: const TextStyle(color: Colors.white
                      // color: message.sender != landlordId
                      //     ? Colors.white
                      //     : Theme.of(context).textTheme.bodyText1!.color
                      ),
                ),
                if (message.type == MessageType.PaymentDue ||
                    message.type == MessageType.PaymentSuccessful) ...[
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
                          Navigator.pushNamed(context, '/payment',
                              arguments: PaymentScreenArguments(payment));
                        } else {
                          Navigator.pushNamed(context, '/paymentSuccess');
                        }
                      } else if (message.type ==
                          MessageType.PaymentSuccessful) {
                        Navigator.pushNamed(context, '/viewPayment',
                            arguments: ViewPaymentScreenArguments(payment));
                      }
                    },
                    child: Text(messageBtnText,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white)),
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
