import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Maintenance/severity_type.dart';
import 'package:rentremedy_mobile/Model/User/user.dart';
import 'maintenance_request_status.dart';
part 'maintenance_request.g.dart';

@JsonSerializable(explicitToJson: true)
class MaintenanceRequest {
  MaintenanceRequest(this.id, this.createdBy, this.severity, this.status,
      this.item, this.location, this.description, this.submissionDate);

  String id;
  User createdBy;
  SeverityType severity;
  MaintenanceRequestStatus status;
  String? statusMessage;
  String item;
  String location;
  String description;
  DateTime submissionDate;
  DateTime? projectedCompletionDate;
  DateTime? completionDate;
  DateTime? cancellationDate;

  factory MaintenanceRequest.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceRequestToJson(this);
}
