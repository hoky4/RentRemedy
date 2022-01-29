import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/User/user.dart';
import 'package:rentremedy_mobile/models/Message/chat_message.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';
import '../auth/login_screen.dart';

class MessageScreen extends StatefulWidget {
  User user;
  MessageScreen({Key? key, required this.user}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late final TextEditingController txtMessage;
  var apiService;
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    apiService = Provider.of<ApiService>(context, listen: false);

    txtMessage = TextEditingController();
    txtMessage.addListener(() {
      final isButtonActive = txtMessage.text.isNotEmpty;
      setState(() => this.isButtonActive = isButtonActive);
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
          StreamBuilder(
            stream: apiService.channel.stream,
            builder: (context, snapshot) {
              return Text(snapshot.hasData ? '${snapshot.data}' : '');
            },
          ),
          // Text('Hi'),
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
                    // await sendMessage();
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

  @override
  void dispose() {
    txtMessage.dispose();
    super.dispose();
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
