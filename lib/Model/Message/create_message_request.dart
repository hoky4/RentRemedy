import 'package:json_annotation/json_annotation.dart';

import 'messaging_socket_response.dart';

part 'create_message_request.g.dart';

@JsonSerializable()
class CreateMessageRequest {
  CreateMessageRequest(
      this.recipient, this.payload, this.messageTempId, this.model);

  String recipient;
  String payload;
  String messageTempId;
  MessagingSocketRequestModelType model;

  factory CreateMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateMessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateMessageRequestToJson(this);

  // Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
  //       'recipient': instance.recipient,
  //       'messageText': instance.messageText,
  //       'messageTempId': instance.messageTempId,
  //       'Model': instance.model,
  //     };
  @override
  String toString() {
    return '{recipient: $recipient, messageText: $payload, messageTextId: $messageTempId, model: $model}}';
  }
}
