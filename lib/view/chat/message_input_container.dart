import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/providers/message_model_provider.dart';
import 'package:rentremedy_mobile/models/Message/model.dart';
import 'package:rentremedy_mobile/models/Message/websocket_message.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';

import 'message_textbox.dart';

class MessageInputContainer extends StatefulWidget {
  List<Message> allMessages;

  MessageInputContainer({
    Key? key,
    required this.allMessages,
  }) : super(key: key);

  @override
  _MessageInputContainerState createState() => _MessageInputContainerState();
}

class _MessageInputContainerState extends State<MessageInputContainer> {
  // var apiService;
  late String landlordId;

  bool isButtonActive = false;

  @override
  void initState() {
    // apiService = Provider.of<ApiService>(context, listen: false);
    landlordId = Provider.of<ApiService>(context, listen: false).landlordId;

    // loadId();

    super.initState();
  }

  // loadId() async {
  //   await apiService.getLandlordId().then((String id) {
  //     landlordId = id;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MessageTextBox(
        onPressed: (String text) async {
          final random = Random().nextInt(100000).toString();
          final message =
              WebSocketMessage(landlordId, text, random, Model.Message);
          var messageModel = context.read<MessageModelProvider>();
          messageModel.sendMessage(message);
        },
        isButtonActive: isButtonActive);
  }
}
