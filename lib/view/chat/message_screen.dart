import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Message/message.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/Providers/auth_model_provider.dart';
import '../../Model/Media/types.dart';
import '../../Model/Media/upload_object_response.dart';
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
          MessageInputContainer(allMessages: widget.allMessages,
          onImagePressed: () async {
            final ImagePicker _picker = ImagePicker();
          ImageSource imgSource = ImageSource.camera;
          // Pick an image
          
          AlertDialog(title:const Text("Select an Image"), 
          actions: <Widget>[ 
            TextButton(child: const Text("Camera"), onPressed: () => {imgSource = ImageSource.camera},),  
            TextButton(child: const Text("Media Gallery"), onPressed: () => {imgSource = ImageSource.gallery},)],
            );

          final XFile? image = await _picker.pickImage(source: imgSource);
          if(image != null)
          {
            UploadObjectResponse response = await apiService.uploadImage(image.name, ObjectType.imageMessage);
            print(response.putUrl);
            print(image.mimeType);
            var r = await http.put(Uri.parse(response.putUrl), 
            headers: <String, String>{
              'Content-Type': image.mimeType ?? 'image/jpeg',
            }, 
            body: await File(image.path).readAsBytes());
            print(r.statusCode);
          }
          },),
        ]));
  }
}
