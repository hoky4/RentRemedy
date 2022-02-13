// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

// class App extends StatelessWidget {
//   const App({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "FLutter tripe",
//       theme: ThemeData(
//         primaryColor: Colors.green,
//       ),
//       home: AddCardScreen(),
//     );
//   }
// }

// payment_screen.dart
class AddCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CardField(
            onCardChanged: (card) {
              print(card);
            },
          ),
          TextButton(
            onPressed: () async {
              // create payment method
              final paymentMethod = await Stripe.instance
                  .createPaymentMethod(const PaymentMethodParams.card());
              print('payment metthod: $paymentMethod');
            },
            child: const Text('pay'),
          )
        ],
      ),
    );
  }
}
