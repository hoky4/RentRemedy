import 'package:flutter/material.dart';

import 'message.dart';

class MessageModel extends ChangeNotifier {
  late List<Message> messages;

  void add(Message message) {
    messages.add(message);
    notifyListeners();
  }
}
