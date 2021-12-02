import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController txtMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(icon: Icon(Icons.menu), onPressed: () {}),
              Text("General")
            ],
          ),
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
            child: ListView.builder(
                itemBuilder: (context, index) => Text("Chat Text")),
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
          IconButton(icon: Icon(Icons.send), onPressed: () {})
        ],
      ),
    );
  }
}
