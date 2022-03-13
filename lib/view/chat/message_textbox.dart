import 'package:flutter/material.dart';

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
    return Container(
      color: Theme.of(context).primaryColorDark,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            IconButton(icon: const Icon(Icons.add), onPressed: () {}),
            Expanded(
              child: TextField(
                controller: txtMessage,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter message',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.blue)),
                ),
              ),
            ),
            IconButton(
              color: Colors.white,
              disabledColor: Colors.grey[700],
              icon: const Icon(Icons.send),
              onPressed: widget.isButtonActive
                  ? () {
                      widget.onPressed(txtMessage.text);
                      txtMessage.clear();
                    }
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
