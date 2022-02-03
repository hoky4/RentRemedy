import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';

import 'message_textbox.dart';

class MessageInputContainer extends StatefulWidget {
  List<Message> conversation;

  MessageInputContainer({
    Key? key,
    required this.conversation,
  }) : super(key: key);

  @override
  _MessageInputContainerState createState() => _MessageInputContainerState();
}

class _MessageInputContainerState extends State<MessageInputContainer> {
  var apiService;
  late String landlordId;
  late String userId;
  var tempId = 0;
  bool isButtonActive = false;

  @override
  void initState() {
    apiService = Provider.of<ApiService>(context, listen: false);
    loadId();

    super.initState();
  }

  loadId() async {
    await apiService.getLandlordId().then((String id) {
      landlordId = id;
    });
    await apiService.getUserId().then((String id) {
      userId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('called MIC build');

    return MessageTextBox(
        onPressed: (String text) async {
          await apiService.sendMessage(input: text);

          setState(() {
            widget.conversation.add(Message.lessArguments(
                userId, landlordId, text, '$tempId', DateTime.now()));
            isButtonActive = false;
          });
          tempId += 1;
        },
        isButtonActive: isButtonActive);
  }
}
