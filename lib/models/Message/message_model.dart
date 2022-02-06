import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/models/Message/websocket_message.dart';

import 'message.dart';

class MessageModel extends ChangeNotifier {
  List<Message> _recentMessages = [];
  List<WebSocketMessage> _sendQueue = [];
  List<WebSocketMessage> _pendingQueue = [];

  UnmodifiableListView<Message> get recentMessages =>
      UnmodifiableListView(_recentMessages);

  UnmodifiableListView<WebSocketMessage> get sendQueue =>
      UnmodifiableListView(_sendQueue);

  UnmodifiableListView<WebSocketMessage> get pendingQueue =>
      UnmodifiableListView(_pendingQueue);

  void messageReceived(Message message) {
    _recentMessages.add(message);
    notifyListeners();
  }

  void sendMessage(WebSocketMessage message) {
    _sendQueue.add(message);
    notifyListeners();
  }

  void moveFirstMessageFromSendToPending() {
    if (_sendQueue.isEmpty) return;

    WebSocketMessage message = _sendQueue.removeAt(0);
    _pendingQueue.add(message);

    notifyListeners();
  }

  void movePendingMessageToRecent(
      String messageTempId, DateTime messageDeliveredDate, String userId) {
    final int index =
        pendingQueue.indexWhere(((msg) => msg.messageTempId == messageTempId));
    if (index != -1) {
      WebSocketMessage deliveredMessage = _pendingQueue.removeAt(index);
      Message wsMsgToMsg = Message.lessArguments(
          userId,
          deliveredMessage.recipient,
          deliveredMessage.messageText,
          deliveredMessage.messageTempId,
          messageDeliveredDate);

      messageReceived(wsMsgToMsg);
    }

    notifyListeners();
  }
}
