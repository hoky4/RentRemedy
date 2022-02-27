import 'package:json_annotation/json_annotation.dart';

enum MaintenanceRequestStatus {
  @JsonValue(0)
  Submitted,
  @JsonValue(1)
  Viewed,
  @JsonValue(2)
  InProgress,
  @JsonValue(3)
  Completed,
  @JsonValue(4)
  Cancelled
}

extension MaintenanceRequestStatusExtension on MaintenanceRequestStatus {
  String get value {
    switch (this) {
      case MaintenanceRequestStatus.Submitted:
        return "Submitted";
      case MaintenanceRequestStatus.Viewed:
        return "Viewed";
      case MaintenanceRequestStatus.InProgress:
        return "InProgress";
      case MaintenanceRequestStatus.Completed:
        return "Completed";
      case MaintenanceRequestStatus.Cancelled:
        return "Cancelled";
      default:
        return "";
    }
  }
}
