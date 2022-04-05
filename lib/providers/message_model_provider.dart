import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:rentremedy_mobile/Model/Message/create_message_request.dart';
import 'package:rentremedy_mobile/Model/Message/message_type.dart';

import '../Model/Media/bucket_object.dart';
import '../Model/Message/message.dart';

class MessageModelProvider extends ChangeNotifier {
  List<Message> _recentMessages = [];
  List<CreateMessageRequest> _sendQueue = [];
  List<CreateMessageRequest> _pendingQueue = [];

  UnmodifiableListView<Message> get recentMessages =>
      UnmodifiableListView(_recentMessages);

  UnmodifiableListView<CreateMessageRequest> get sendQueue =>
      UnmodifiableListView(_sendQueue);

  UnmodifiableListView<CreateMessageRequest> get pendingQueue =>
      UnmodifiableListView(_pendingQueue);

  void messageReceived(Message message) {
    _recentMessages.add(message);
    notifyListeners();
  }

  void sendMessage(CreateMessageRequest message) {
    _sendQueue.add(message);
    notifyListeners();
  }

  void moveFirstMessageFromSendToPending() {
    if (_sendQueue.isEmpty) return;

    CreateMessageRequest message = _sendQueue.removeAt(0);
    _pendingQueue.add(message);

    notifyListeners();
  }

  void movePendingMessageToRecent(String messageTempId, DateTime messageDeliveredDate, String userId, BucketObject? media) {
    final int index =
        pendingQueue.indexWhere(((msg) => msg.messageTempId == messageTempId));
    if (index != -1) {
      CreateMessageRequest deliveredMessage = _pendingQueue.removeAt(index);
      MessageType type = media == null ? MessageType.Text : MessageType.Image;
      Message wsMsgToMsg = Message.lessArguments(
          userId,
          deliveredMessage.recipient,
          deliveredMessage.payload,
          deliveredMessage.messageTempId,
          messageDeliveredDate,
          media,
          type);

      messageReceived(wsMsgToMsg);
    }

    notifyListeners();
  }

  void clearRecentMessages() {
    _recentMessages.clear();
  }
}
