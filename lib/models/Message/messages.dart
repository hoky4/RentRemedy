import 'package:json_annotation/json_annotation.dart';

import 'model.dart';
part 'messages.g.dart';

@JsonSerializable()
class Messages {
  Messages(this.recipient, this.messageText, this.messageTempId, this.model);

  String recipient;
  String messageText;
  String messageTempId;
  Model model;

  factory Messages.fromJson(Map<String, dynamic> json) =>
      _$MessagesFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesToJson(this);

  // Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
  //       'recipient': instance.recipient,
  //       'messageText': instance.messageText,
  //       'messageTempId': instance.messageTempId,
  //       'Model': instance.model,
  //     };
  @override
  String toString() {
    // TODO: implement toString
    return '{recipient: ${this.recipient}, messageText: ${this.messageText}, messageTextId: ${this.messageTempId}, model: ${this.model}}}';
  }
}
