import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/providers/api_service_provider.dart';
import 'package:rentremedy_mobile/providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/view/payment/view_payment_screen.dart';
import 'package:rentremedy_mobile/view/payment/view_payments_screen.dart';
import 'message_box.dart';
import 'message_input_container.dart';

class MessageScreen extends StatefulWidget {
  List<Message> allMessages;
  MessageScreen({Key? key, required this.allMessages}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late ApiServiceProvider apiService;

  @override
  void initState() {
    super.initState();
    apiService = Provider.of<ApiServiceProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var authModel = context.read<AuthModelProvider>();

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              // IconButton(icon: Icon(Icons.menu), onPressed: () {}),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  // Navigator.pushReplacementNamed(context, '/login');
                  authModel.logoutUser();
                },
              ),
              const Text("General")
            ],
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: const Icon(Icons.comment_rounded), onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.attach_money_outlined),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ViewPaymentsScreen()));
                }),
            IconButton(
                icon: const Icon(Icons.build_circle_outlined),
                onPressed: () {}),
          ],
        ),
        body: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: widget.allMessages.length,
                  itemBuilder: (context, index) => MessageBox(
                        message: widget.allMessages[index],
                      )),
            ),
          ),
          MessageInputContainer(allMessages: widget.allMessages),
        ]));
  }
}
