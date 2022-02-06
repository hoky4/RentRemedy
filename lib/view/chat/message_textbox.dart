import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';

class MessageTextBox extends StatefulWidget {
  Future<void> Function(String text) onPressed;
  bool isButtonActive;

  MessageTextBox(
      {Key? key, required this.onPressed, required this.isButtonActive})
      : super(key: key);

  @override
  _MessageTextBox createState() => _MessageTextBox();
}

class _MessageTextBox extends State<MessageTextBox> {
  late final TextEditingController txtMessage;
  @override
  void initState() {
    super.initState();

    txtMessage = TextEditingController();
    txtMessage.addListener(() {
      final isButtonActive = txtMessage.text.isNotEmpty;
      setState(() => widget.isButtonActive = isButtonActive);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: widget.isButtonActive
                ? () {
                    print('Send btn pressed');
                    widget.onPressed(txtMessage.text);
                    txtMessage.clear();
                  }
                : null,
          )
        ],
      ),
    );
  }
}
