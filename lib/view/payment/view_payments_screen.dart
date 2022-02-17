import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Payments/payment.dart';
import 'package:rentremedy_mobile/providers/api_service_provider.dart';
import 'package:rentremedy_mobile/view/payment/view_payment_screen.dart';

class ViewPaymentsScreen extends StatefulWidget {
  const ViewPaymentsScreen({Key? key}) : super(key: key);

  @override
  _ViewPaymentsScreenState createState() => _ViewPaymentsScreenState();
}

class _ViewPaymentsScreenState extends State<ViewPaymentsScreen> {
  late ApiServiceProvider apiService;

  late List<Payment> payments;

  @override
  void initState() {
    super.initState();
    apiService = Provider.of<ApiServiceProvider>(context, listen: false);
    payments = [];
    fetchPayments();
  }

  fetchPayments() async {
    List<Payment> paymentsList = await apiService.getAllPayments();
    setState(() {
      payments = paymentsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: payments.length,
                itemBuilder: (context, index) => PaymentItem(
                      payment: payments[index],
                    )),
          ),
        ),
      ]),
    );
  }
}

class PaymentItem extends StatelessWidget {
  Payment payment;
  PaymentItem({Key? key, required this.payment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(DateFormat.yMMMMd('en_US').format(payment.dueDate)),
      subtitle: payment.paymentDate != null
          ? const Text('Status: Paid')
          : const Text('Status: Unpaid'),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewPaymentScreen(payment: payment)));
      },
    ));
  }
}
