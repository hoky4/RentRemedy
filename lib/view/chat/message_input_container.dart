import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';

import 'message_textfield.dart';

class MessageInputContainer extends StatefulWidget {
  List<Message> conversation;
  String tempId;

  MessageInputContainer(
      {Key? key, required this.conversation, required this.tempId})
      : super(key: key);

  @override
  _MessageInputContainerState createState() => _MessageInputContainerState();
}

class _MessageInputContainerState extends State<MessageInputContainer> {
  var apiService;
  late String landlordId;
  late String userId;
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
    return MessageTextField(
      onPressed: (String text, String tempId) async {
        await apiService.sendMessage(input: text, tempId: tempId);
        setState(() {
          widget.conversation.add(Message.lessArguments(
              userId, landlordId, text, '$tempId', DateTime.now(), false));
          isButtonActive = false;
        });
      },
      isButtonActive: isButtonActive,
      tempId: widget.tempId,
    );
  }
}
