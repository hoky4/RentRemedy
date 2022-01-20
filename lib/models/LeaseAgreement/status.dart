import 'package:json_annotation/json_annotation.dart';

enum Status
{
  @JsonValue(0)
  Incomplete,
  @JsonValue(1)
  Inactive,
  @JsonValue(2)
  Unassigned,
  @JsonValue(3)
  AssignedUnsigned,
  @JsonValue(4)
  AssignedSigned,
  @JsonValue(5)
  Completed,
  @JsonValue(6)
  Terminated
}