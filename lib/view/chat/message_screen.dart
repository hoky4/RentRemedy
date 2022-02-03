import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:rentremedy_mobile/view/auth/login_screen.dart';

import 'message_box.dart';
import 'message_input_container.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  var apiService;
  late List<Message> conversation;
  var tempId = 0;

  @override
  void initState() {
    super.initState();

    apiService = Provider.of<ApiService>(context, listen: false);
    conversation = apiService.conversation;
  }

  @override
  Widget build(BuildContext context) {
    print('called MUI build');
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
              print('called MUI stream builder');
              print('hasData: ${snapshot.hasData}');
              print('Data: ${snapshot.data}');

              Map<String, dynamic> responseMap;
              String inboundMessage = snapshot.data.toString();
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  responseMap = jsonDecode(inboundMessage);

                  Message message;
                  if (responseMap['sender'] != null) {
                    message = apiService
                        .parseInboundMessageFromSocket(inboundMessage);
                    conversation.add(message);
                  } else if (responseMap['messageTempId'] != null) {
                    print('recv response');
                    final id = responseMap['messageTempId'];
                    print('resp-id: $id');
                    final int index1 = conversation
                        .indexWhere(((msg) => msg.messageTempId == '59'));
                    if (index1 != -1) {
                      print('Index: $index1');
                      conversation[index1].updateDelivered();
                      // conversation[index1].delivered = true;
                      print('tempid: ${conversation[index1].messageTempId}');
                      print('msgtxt: ${conversation[index1].messageText}');
                    }
                  }
                  // TODO: check for response messsages or throw error
                }
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: conversation.length,
                      itemBuilder: (context, index) => ChangeNotifierProvider(
                            create: (context) => conversation[index],
                            child: MessageBox(message: conversation[index]),
                          )),
                ),
              );
            },
          ),
          MessageInputContainer(
            conversation: conversation,
            tempId: '59',
          ),
        ]));
  }
}
