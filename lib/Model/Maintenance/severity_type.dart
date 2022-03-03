import 'package:json_annotation/json_annotation.dart';

enum SeverityType {
  @JsonValue(0)
  None,
  @JsonValue(1)
  Low,
  @JsonValue(2)
  Medium,
  @JsonValue(3)
  High,
  @JsonValue(4)
  Emergency
}

extension SeverityTypeExtension on SeverityType {
  String get value {
    switch (this) {
      case SeverityType.None:
        return "None";
      case SeverityType.Low:
        return "Low";
      case SeverityType.Medium:
        return "Medium";
      case SeverityType.High:
        return "High";
      case SeverityType.Emergency:
        return "Emergency";
      default:
        return "";
    }
  }
}
