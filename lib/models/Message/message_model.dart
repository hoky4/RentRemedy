import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/models/Message/websocket_message.dart';

import 'message.dart';

class MessageModel extends ChangeNotifier {
  List<Message> recentMessages = [];
  List<WebSocketMessage> sendQueue = [];
  List<WebSocketMessage> pendingQueue = [];

  void messageReceived(Message message) {
    recentMessages.add(message);
    notifyListeners();
  }

  void sendMessage(WebSocketMessage message) {
    sendQueue.add(message);
    notifyListeners();
  }
}
