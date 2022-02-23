import 'package:json_annotation/json_annotation.dart';

enum DueDateType {
  @JsonValue(0)
  StartOfMonth,
  @JsonValue(1)
  EndOfMonth,
  @JsonValue(2)
  DayOfMonth
}

extension DueDateTypeExtension on DueDateType {
  String get value {
    switch (this) {
      case DueDateType.StartOfMonth:
        return "Start of Month";
      case DueDateType.EndOfMonth:
        return "End of Month";
      case DueDateType.DayOfMonth:
        return "Day of Month";
      default:
        return "";
    }
  }
}
