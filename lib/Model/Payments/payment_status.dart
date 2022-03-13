import 'package:json_annotation/json_annotation.dart';

enum PaymentStatus {
  @JsonValue(0)
  Pending,
  @JsonValue(1)
  Late,
  @JsonValue(2)
  Paid,
  @JsonValue(3)
  PaidLate,
  @JsonValue(4)
  Forgiven,
  @JsonValue(5)
  Submitted,
  @JsonValue(6)
  SubmittedLate,
  @JsonValue(7)
  Terminated
}

extension PaymentStatusExtension on PaymentStatus {
  String get value {
    switch (this) {
      case PaymentStatus.Pending:
        return "Pending";
      case PaymentStatus.Late:
        return "Late";
      case PaymentStatus.Paid:
        return "Paid";
      case PaymentStatus.PaidLate:
        return "Paid Late";
      case PaymentStatus.Forgiven:
        return "Forgiven";
      case PaymentStatus.Submitted:
        return "Submitted";
      case PaymentStatus.SubmittedLate:
        return "Submitted Late";
      case PaymentStatus.Terminated:
        return "Terminated";
      default:
        return "";
    }
  }
}
