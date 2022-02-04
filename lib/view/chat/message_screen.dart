import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:rentremedy_mobile/view/auth/login_screen.dart';

import 'message_box.dart';
import 'message_input_container.dart';

class MessageScreen extends StatefulWidget {
  List<Message> allMessages;
  MessageScreen({Key? key, required this.allMessages}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  var apiService;
  // late List<Message> conversation;

  @override
  void initState() {
    super.initState();

    apiService = Provider.of<ApiService>(context, listen: false);
    // conversation = apiService.conversation;
  }

  @override
  Widget build(BuildContext context) {
    print('called MS build');
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: widget.allMessages.length,
                  itemBuilder: (context, index) => MessageBox(
                        message: widget.allMessages[index],
                      )),
            ),
          ),
          MessageInputContainer(allMessages: widget.allMessages),
        ]));
  }
}
