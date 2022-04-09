import 'package:json_annotation/json_annotation.dart';

enum ReviewStatus {
  @JsonValue(0)
  Pending,
  @JsonValue(1)
  Rejected,
  @JsonValue(2)
  FilledOut,
}

extension ReviewStatusExtension on ReviewStatus {
  String get value {
    switch (this) {
      case ReviewStatus.Pending:
        return "Pending";
      case ReviewStatus.Rejected:
        return "Low";
      case ReviewStatus.FilledOut:
        return "Filled Out";
      default:
        return "";
    }
  }
}
