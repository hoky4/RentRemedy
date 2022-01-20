import 'package:json_annotation/json_annotation.dart';

enum Status
{
  @JsonValue(0)
  Incomplete,
  @JsonValue(2)
  Inactive,
  @JsonValue(3)
  Unassigned,
  @JsonValue(4)
  AssignedUnsigned,
  @JsonValue(5)
  AssignedSigned,
  @JsonValue(6)
  Completed,
  @JsonValue(7)
  Terminated
}