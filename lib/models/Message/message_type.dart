import 'package:json_annotation/json_annotation.dart';

enum MessageType {
  @JsonValue(0)
  Text,
  @JsonValue(1)
  PaymentDue,
  @JsonValue(2)
  PaymentSuccessful,
<<<<<<< HEAD
  @JsonValue(3)
  PaymentReceived,
  @JsonValue(4)
=======
  @JsonValue(1)
  PaymentProcessing,
  @JsonValue(2)
>>>>>>> a3ea0a2043db9ed9c4f36d089d0bc1cb44a093b8
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
<<<<<<< HEAD
      case MessageType.PaymentReceived:
        return "Payment Received";
      case MessageType.WelcomeMessage:
        return "Welcome Message";
=======
      case MessageType.PaymentProcessing:
        return "Payment Processing";
      case MessageType.WelcomeMessage:
        return "Welcome";
>>>>>>> a3ea0a2043db9ed9c4f36d089d0bc1cb44a093b8
      default:
        return "";
    }
  }
}
