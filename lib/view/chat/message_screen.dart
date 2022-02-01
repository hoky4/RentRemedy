import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/models/User/user.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import '../auth/login_screen.dart';
import 'message_box.dart';

class MessageScreen extends StatefulWidget {
  User user;
  MessageScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late final TextEditingController txtMessage;
  var apiService;
  var conversation;
  late String landlordId;
  late String userId;
  var tempId = 0;
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    apiService = Provider.of<ApiService>(context, listen: false);
    conversation = apiService.conversation;
    loadId();

    txtMessage = TextEditingController();
    txtMessage.addListener(() {
      final isButtonActive = txtMessage.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });
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
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              // IconButton(icon: Icon(Icons.menu), onPressed: () {}),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await apiService.logout();
                  apiService.closeSocket();

                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                },
              ),
              Text("General")
            ],
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(icon: Icon(Icons.comment_rounded), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.attach_money_outlined), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.build_circle_outlined), onPressed: () {}),
          ],
        ),
        body: Column(children: [
          StreamBuilder(
            stream: apiService.channel.stream,
            builder: (context, snapshot) {
              // TODO: check for messages not sent
              print('builder called');

              Map<String, dynamic> responseMap;
              String inboundMessage = snapshot.data.toString();
              if (snapshot.hasData) {
                responseMap = jsonDecode(inboundMessage);

                Message message;
                if (responseMap['sender'] != null) {
                  message =
                      apiService.parseInboundMessageFromSocket(inboundMessage);
                  conversation.add(message);
                  print('\nadded message');
                }
                // TODO: check for response messsages or throw error
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: conversation.length,
                      itemBuilder: (context, index) => MessageBox(
                            message: conversation[index],
                          )),
                ),
              );
            },
          ),
          MessageInputField(),
        ]));
  }

  Widget MessageInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {}),
          Expanded(
            child: TextField(
              controller: txtMessage,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Enter message',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.blue)),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: isButtonActive
                ? () async {
                    await apiService.sendMessage(input: txtMessage.text);
                    setState(() {
                      conversation.add(Message.withoutArguments(
                          userId,
                          landlordId,
                          txtMessage.text,
                          '$tempId',
                          DateTime.now()));
                      isButtonActive = false;
                      txtMessage.clear();
                    });
                    tempId += 1;
                  }
                : null,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    apiService.channel.sink.close();
    txtMessage.dispose();
    super.dispose();
  }
}
