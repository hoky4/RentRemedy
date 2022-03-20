import 'package:json_annotation/json_annotation.dart';

enum Status {
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

extension StatusExtension on Status {
  String get value {
    switch (this) {
      case Status.Incomplete:
        return "Incomplete";
      case Status.Unassigned:
        return "Unassigned";
      case Status.AssignedUnsigned:
        return "Waiting for Landlord Signature";
      case Status.AssignedSigned:
        return "Signed";
      case Status.Completed:
        return "Completed";
      case Status.Terminated:
        return "Terminated";
      default:
        return "";
    }
  }
}
