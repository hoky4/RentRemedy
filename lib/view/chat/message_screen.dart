import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rentremedy_mobile/models/Message/model.dart';
import 'package:rentremedy_mobile/models/User/user.dart';
import 'package:rentremedy_mobile/models/Message/chat_message.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:rentremedy_mobile/models/Message/messages.dart';

import '../auth/login_screen.dart';

class MessageScreen extends StatefulWidget {
  User user;
  MessageScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late final TextEditingController txtMessage;
  bool isButtonActive = false;
  ApiService apiService = ApiService();
  // WebSocketChannel channel = WebSocketChannel.connect(
  //   Uri.parse('wss://10.0.2.2:5001/api/ws/connect'),
  // );
  var channel;
  var isLoading = false;

  @override
  void initState() {
    super.initState();

    txtMessage = TextEditingController();
    txtMessage.addListener(() {
      final isButtonActive = txtMessage.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
    });

    // apiService.connectToWebSocket();
    setupConnection();
    // channel = apiService.channel;
  }

  Future<void> setupConnection() async {
    var cookie = await readFromSecureStorage();
    channel = IOWebSocketChannel.connect(
      'wss://10.0.2.2:5001/api/ws/connect',
      headers: <String, dynamic>{
        'Content-Type': 'application/json',
        "Cookie": cookie
      },
    );

    // final landlordId = await getLandlordId();
    // print('landlord-id: $landlordId');

    // await WebSocket.connect(
    //   "wss://10.0.2.2:5001/api/ws/connect",
    //   headers: <String, dynamic>{
    //     'Content-Type': 'application/json',
    //     "Cookie": cookie
    //   },
    // ).then((ws) {
    //   // create the stream channel
    //   channel = IOWebSocketChannel(ws);
    //   final message = Messages(
    //       "61f31932f702f1788e19aac0", "Hey landlord", "2", Model.Message);

    //   channel.sink.add(message.toJson());
    // });

    setState(() {
      print('isloading done');
      isLoading = true;
    });
  }

  @override
  void dispose() {
    print('closed channel');
    channel.sink.close();
    txtMessage.dispose();
    super.dispose();
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
                  itemCount: demoChatMessage.length,
                  itemBuilder: (context, index) => Message(
                        message: demoChatMessage[index],
                      )),
            ),
          ),
          // isLoading
          //     ? StreamBuilder(
          //         stream: channel.stream,
          //         builder: (context, snapshot) {
          //           return Text(snapshot.hasData ? '${snapshot.data}' : '');
          //         },
          //       )
          //     : Text("Loading"),
          Text('Hi'),
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
                    await sendMessage();
                    setState(() {
                      final userInput =
                          ChatMessage(text: txtMessage.text, isSender: true);
                      demoChatMessage.add(userInput);
                      isButtonActive = false;
                      txtMessage.clear();
                    });
                  }
                : null,
          )
        ],
      ),
    );
  }

  Future<String> getLandlordId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = (prefs.getString('landlordId') ?? '');

    return id;
  }

  sendMessage() async {
    final landlordId = await getLandlordId();
    print('landlord-id: $landlordId');
    final message = Messages(
        "61f31932f702f1788e19aac0", "Hey landlord", "2", Model.Message);
    print('message-str: ${message.toString()}');
    print('msg-json: ${message.toJson()}');

    final msgJson = message.toJson();
    for (final mapEntry in msgJson.entries) {
      final key = mapEntry.key;
      final value = mapEntry.value;
      print('$key: $value');
    }

    channel.sink.add(message.toJson());
    // channel.sink.add(
    // '{ "recipient":"61f31932f702f1788e19aac0", "messageText":"Hello, landlord", "messageTempId":"2", "model": 1 }');
  }

  Future<String> readFromSecureStorage() async {
    final storage = FlutterSecureStorage();
    var cookie = (await storage.read(key: "myCookie"))!;
    print('read cookie: $cookie');
    return cookie;
  }
}

class Message extends StatelessWidget {
  final ChatMessage message;
  const Message({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[Icon(Icons.person_pin)],
          Container(
            // margin: EdgeInsets.only(top: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(message.isSender ? 1 : 0.08),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                  color: message.isSender
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyText1!.color),
            ),
          ),
        ],
      ),
    );
  }
}
