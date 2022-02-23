import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Message/message.dart';
import 'package:rentremedy_mobile/Model/User/user.dart';
import '../View/auth/login_screen.dart';
import '../View/Chat/message_box.dart';
import '../View/Chat/message_textbox.dart';

class MessageScreen2 extends StatefulWidget {
  // User user;
  MessageScreen2({Key? key}) : super(key: key);

  @override
  _MessageScreen2State createState() => _MessageScreen2State();
}

class _MessageScreen2State extends State<MessageScreen2> {
  var apiService;
  var conversation;
  late String landlordId;
  late String userId;
  var tempId = 0;
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    // apiService = Provider.of<ApiService>(context, listen: false);
    conversation = apiService.conversation;
    loadId();
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
    print('called-build');
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
              print('called-stream builder');

              if (snapshot.connectionState == ConnectionState.active) {
                Map<String, dynamic> responseMap;
                String inboundMessage = snapshot.data.toString();
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    responseMap = jsonDecode(inboundMessage);

                    Message message;
                    if (responseMap['sender'] != null) {
                      print('recv inb-msg');
                      message = apiService
                          .parseInboundMessageFromSocket(inboundMessage);
                      conversation.add(message);
                    }
                  }
                }
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
          MessageTextBox(
              onPressed: (String text) async {
                await apiService.sendMessage(input: text);
                setState(() {
                  print('called setState');
                  conversation.add(Message.lessArguments(
                      userId, landlordId, text, '$tempId', DateTime.now()));
                  isButtonActive = false;
                });
                tempId += 1;
              },
              isButtonActive: isButtonActive),
        ]));
  }

  @override
  void dispose() {
    apiService.channel.sink.close();
    super.dispose();
  }
}
