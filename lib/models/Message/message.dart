import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'message_type.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
class Message with ChangeNotifier {
  Message(
      {required this.id,
      required this.type,
      required this.sender,
      required this.recipient,
      required this.sentFromSystem,
      required this.creationDate,
      required this.messageText,
      this.messageTempId,
      this.readDate,
      this.actionId,
      this.delivered = true});

  Message.lessArguments(this.sender, this.recipient, this.messageText,
      this.messageTempId, this.creationDate, this.delivered,
      [this.id = '',
      this.type = MessageType.Text,
      this.sentFromSystem = false,
      this.readDate,
      this.actionId]);

  String id;
  MessageType type;
  String sender;
  String recipient;
  bool sentFromSystem;
  DateTime creationDate;
  String messageText;
  String? messageTempId;
  DateTime? readDate;
  String? actionId;
  bool delivered;
  bool _disposed = false;

  void updateDelivered() {
    delivered = true;
    notifyListeners();
  }

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
