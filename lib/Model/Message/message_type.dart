import 'package:json_annotation/json_annotation.dart';

enum MessageType {
  @JsonValue(0)
  Text,
  @JsonValue(1)
  PaymentDue,
  @JsonValue(2)
  PaymentSuccessful,
  @JsonValue(3)
  PaymentProcessing,
  @JsonValue(4)
  WelcomeMessage,
  @JsonValue(5)
  MaintenanceCreated,
  @JsonValue(6)
  MaintenanceCompleted,
  @JsonValue(7)
  MaintenanceCancelled,
  @JsonValue(8)
  MaintenanceUpdated,
  @JsonValue(9)
  TerminationNotification,
  @JsonValue(10)
  Image
}

extension MessageTypeExtension on MessageType {
  String get value {
    switch (this) {
      case MessageType.Text:
        return "Text";
      case MessageType.PaymentDue:
        return "Pay Now";
      case MessageType.PaymentSuccessful:
        return "View Payment";
      case MessageType.PaymentProcessing:
        return "Payment Processing";
      case MessageType.WelcomeMessage:
        return "Welcome Message";
      case MessageType.MaintenanceCreated:
        return "View Request";
      case MessageType.MaintenanceCompleted:
        return "View Completion";
      case MessageType.MaintenanceCancelled:
        return "View Cancellation";
      case MessageType.MaintenanceUpdated:
        return "View Update";
      case MessageType.TerminationNotification:
        return "Pay Termination";
      default:
        return "";
    }
  }
}
