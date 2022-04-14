import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Media/bucket_object.dart';
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
      this.actionId,
      this.media);

  Message.lessArguments(this.sender, this.recipient, this.messageText,
      this.messageTempId, this.creationDate, this.media, this.type,
      {this.id = '',
      this.sentFromSystem = false,
      this.readDate,
      this.actionId});

  String id;
  MessageType type;
  String sender;
  String recipient;
  bool sentFromSystem;
  DateTime creationDate;
  String? messageText;
  String? messageTempId;
  DateTime? readDate;
  String? actionId;
  BucketObject? media;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
