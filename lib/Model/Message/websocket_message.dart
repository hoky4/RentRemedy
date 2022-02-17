import 'package:json_annotation/json_annotation.dart';

import 'model.dart';
part 'websocket_message.g.dart';

@JsonSerializable()
class WebSocketMessage {
  WebSocketMessage(
      this.recipient, this.messageText, this.messageTempId, this.model);

  String recipient;
  String messageText;
  String messageTempId;
  Model model;

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) =>
      _$WebSocketMessageFromJson(json);

  Map<String, dynamic> toJson() => _$WebSocketMessageToJson(this);

  // Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
  //       'recipient': instance.recipient,
  //       'messageText': instance.messageText,
  //       'messageTempId': instance.messageTempId,
  //       'Model': instance.model,
  //     };
  @override
  String toString() {
    return '{recipient: ${this.recipient}, messageText: ${this.messageText}, messageTextId: ${this.messageTempId}, model: ${this.model}}}';
  }
}
