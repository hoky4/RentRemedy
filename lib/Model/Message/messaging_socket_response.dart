import 'package:json_annotation/json_annotation.dart';

abstract class MessagingSocketResponse {
  MessagingSocketResponseModelType model;
  MessagingSocketResponse(this.model);
}

enum MessagingSocketResponseModelType {
  @JsonValue(0)
  message,
  @JsonValue(1)
  messageDelivered,
  @JsonValue(2)
  messageRead,
  @JsonValue(3)
  mediaMessage,
}

enum MessagingSocketRequestModelType {
  @JsonValue(0)
  messageRead,
  @JsonValue(1)
  createMessage,
  @JsonValue(2)
  imageMessage
}
