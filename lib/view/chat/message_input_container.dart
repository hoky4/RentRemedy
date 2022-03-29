import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Media/types.dart';
import 'package:rentremedy_mobile/Model/Media/upload_object_response.dart';
import 'package:rentremedy_mobile/Model/Message/message.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/Providers/message_model_provider.dart';
import 'package:rentremedy_mobile/View/Chat/message_textbox.dart';
import 'package:rentremedy_mobile/providers/api_service_provider.dart';
import '../../Model/Message/create_message_request.dart';
import '../../Model/Message/messaging_socket_response.dart';
import 'package:http/http.dart' as http;

class MessageInputContainer extends StatefulWidget {
  List<Message> allMessages;
  Future<void> Function() onImagePressed;

  MessageInputContainer({
    Key? key,
    required this.allMessages,
    required this.onImagePressed
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
          final message = CreateMessageRequest(landlordId!, text, random, MessagingSocketRequestModelType.createMessage);
          var messageModel = context.read<MessageModelProvider>();
          messageModel.sendMessage(message);
        },
        isButtonActive: isButtonActive,
        onImagePressed: widget.onImagePressed);

  }
}
