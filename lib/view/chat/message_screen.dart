import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Message/message.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import 'message_box.dart';
import 'message_input_container.dart';

class MessageScreen extends StatefulWidget {
  List<Message> allMessages;
  ScrollController scrollController;

  MessageScreen(
      {Key? key, required this.allMessages, required this.scrollController})
      : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late ApiServiceProvider apiService;
  late bool isLoading = false;
  @override
  void initState() {
    super.initState();
    apiService = Provider.of<ApiServiceProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var authModel = context.read<AuthModelProvider>();

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  controller: widget.scrollController,
                  reverse: true,
                  itemCount: widget.allMessages.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final reversedIndex = widget.allMessages.length - 1 - index;
                    return MessageBox(
                      message: widget.allMessages[reversedIndex],
                    );
                  }),
            ),
          ),
          MessageInputContainer(allMessages: widget.allMessages),
        ]));
  }
}
