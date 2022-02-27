import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Payments/payment.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/View/payment/payment_screen.dart';
import 'package:rentremedy_mobile/View/payment/view_payment_screen.dart';

class ViewPaymentsScreen extends StatefulWidget {
  const ViewPaymentsScreen({Key? key}) : super(key: key);

  @override
  _ViewPaymentsScreenState createState() => _ViewPaymentsScreenState();
}

class _ViewPaymentsScreenState extends State<ViewPaymentsScreen>
    with AutomaticKeepAliveClientMixin<ViewPaymentsScreen> {
  late ApiServiceProvider apiService;

  late List<Payment> payments;
  late bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiService = Provider.of<ApiServiceProvider>(context, listen: false);
    payments = [];
    fetchPayments();
  }

  Future fetchPayments() async {
    List<Payment> paymentsList = await apiService.getAllPayments();
    if (mounted) {
      setState(() {
        payments = paymentsList;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            body: Column(children: [
              if (payments != null) ...[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RefreshIndicator(
                      child: ListView.builder(
                          itemCount: payments.length,
                          itemBuilder: (context, index) =>
                              PaymentItem(payment: payments[index])),
                      onRefresh: fetchPayments,
                    ),
                  ),
                ),
              ] else ...[
                const Center(child: Text("No payments yet"))
              ],
            ]),
          )
        : const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  @override
  bool get wantKeepAlive => true;
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
        if (payment.paymentDate != null) {
          Navigator.pushNamed(context, '/viewPayment',
              arguments: ViewPaymentScreenArguments(payment));
        } else {
          Navigator.pushNamed(context, '/payment',
              arguments: PaymentScreenArguments(payment));
        }
      },
    ));
  }
}
