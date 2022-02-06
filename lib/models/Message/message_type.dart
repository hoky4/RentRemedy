import 'package:json_annotation/json_annotation.dart';

enum MessageType {
  @JsonValue(0)
  Text,
  @JsonValue(1)
  PaymentDue,
  @JsonValue(2)
  PaymentSuccessful,
  @JsonValue(3)
  PaymentReceived,
  @JsonValue(4)
  WelcomeMessage
}

extension MessageTypeExtension on MessageType {
  String get value {
    switch (this) {
      case MessageType.Text:
        return "Text";
      case MessageType.PaymentDue:
        return "Payment Due";
      case MessageType.PaymentSuccessful:
        return "Payment Successful";
      case MessageType.PaymentReceived:
        return "Payment Received";
      case MessageType.WelcomeMessage:
        return "Welcome Message";
      default:
        return "";
    }
  }
}
