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
  PaymentReceived,
  @JsonValue(5)
  WelcomeMessage,
  @JsonValue(6)
  MaintenanceCreated,
  @JsonValue(7)
  MaintenanceCompleted,
  @JsonValue(8)
  MaintenanceCancelled,
  @JsonValue(9)
  MaintenanceUpdated,
  @JsonValue(10)
  TerminationNotification
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
      case MessageType.PaymentReceived:
        return "View Payment";
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
