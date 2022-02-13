import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/providers/message_model_provider.dart';
import 'package:rentremedy_mobile/models/Message/model.dart';
import 'package:rentremedy_mobile/models/Message/websocket_message.dart';
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
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? landlordId = context.read<AuthModelProvider>().landlordId;

    return MessageTextBox(
        onPressed: (String text) async {
          final random = Random().nextInt(100000).toString();
          final message =
              WebSocketMessage(landlordId!, text, random, Model.Message);
          var messageModel = context.read<MessageModelProvider>();
          messageModel.sendMessage(message);
        },
        isButtonActive: isButtonActive);
  }
}
