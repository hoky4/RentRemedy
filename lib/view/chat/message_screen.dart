import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Message/create_message_request.dart';
import 'package:rentremedy_mobile/Model/Message/message.dart';
import 'package:rentremedy_mobile/Model/Message/messaging_socket_response.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import 'package:rentremedy_mobile/view/Components/image_picker.dart';
import 'package:mime/mime.dart';
import '../../Model/Media/types.dart';
import '../../Model/Media/upload_object_response.dart';
import '../../Providers/message_model_provider.dart';
import 'message_box.dart';
import 'message_input_container.dart';
import 'package:http/http.dart' as http;

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

  Future<void> onImagePicked(XFile file) async 
  {
    UploadObjectResponse response = await apiService.uploadImage(file.name, ObjectType.imageMessage);
    print(lookupMimeType(file.path));
    var r = await http.put(Uri.parse(response.putUrl), 
    headers: <String, String>{
      'Content-Type': lookupMimeType(file.path) ?? 'unknown',
      }, 
    body: await File(file.path).readAsBytes());
    print(r.statusCode);
    String? landlordId = context.read<AuthModelProvider>().landlordId;
    final random = Random().nextInt(100000).toString();
    CreateMessageRequest message = CreateMessageRequest(landlordId!, response.bucketObject.id, random, MessagingSocketRequestModelType.imageMessage);
    var messageModel = context.read<MessageModelProvider>();
    messageModel.sendMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    var authModel = context.read<AuthModelProvider>();
    ImageFilePicker imageFilePicker = ImageFilePicker(onImagePicked: onImagePicked);

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
          MessageInputContainer(allMessages: widget.allMessages,
          onImagePressed: () async {
            imageFilePicker.showFilePicker(context);
          },),
        ]));
  }
}
