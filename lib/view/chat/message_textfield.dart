import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/models/Message/message.dart';
import 'package:rentremedy_mobile/networking/api_service.dart';

class MessageTextField extends StatefulWidget {
  Future<void> Function(String text, String tempId) onPressed;
  bool isButtonActive;
  String tempId;

  MessageTextField(
      {Key? key,
      required this.onPressed,
      required this.isButtonActive,
      required this.tempId})
      : super(key: key);

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
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
                    widget.onPressed(txtMessage.text, widget.tempId);
                    txtMessage.clear();
                  }
                : null,
          )
        ],
      ),
    );
  }
}
