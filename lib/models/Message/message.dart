import 'package:json_annotation/json_annotation.dart';
import 'message_type.dart';

part 'message.g.dart';

@JsonSerializable(explicitToJson: true)
class Message {
  Message(
      this.id,
      this.type,
      this.sender,
      this.recipient,
      this.sentFromSystem,
      this.creationDate,
      this.messageText,
      this.messageTempId,
      this.readDate,
      this.actionId);

  String id;
  MessageType type;
  String sender;
  String recipient;
  bool sentFromSystem;
  DateTime creationDate;
  String messageText;
  String messageTempId;
  DateTime? readDate;
  String? actionId;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
