import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Maintenance/severity_type.dart';
part 'maintenance_request_request.g.dart';

@JsonSerializable(explicitToJson: true)
class MaintenanceRequestRequest {
  MaintenanceRequestRequest(this.leaseAgreementId, this.propertyId,
      this.severity, this.item, this.location, this.description, this.dateTime,);

  // User user;
  String leaseAgreementId;
  String propertyId;
  SeverityType severity;
  String item;
  String location;
  String description;
  DateTime? dateTime;

  factory MaintenanceRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceRequestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceRequestRequestToJson(this);
}
