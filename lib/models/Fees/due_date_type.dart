import 'package:json_annotation/json_annotation.dart';

enum DueDateType
{
  @JsonValue(0)
  StartOfMonth,
  @JsonValue(1)
  EndOfMonth,
  @JsonValue(2)
  DayOfMonth
}