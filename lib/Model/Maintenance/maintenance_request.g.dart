// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceRequest _$MaintenanceRequestFromJson(Map<String, dynamic> json) =>
    MaintenanceRequest(
      json['id'] as String,
      json['leaseAgreementId'] as String,
      User.fromJson(json['createdBy'] as Map<String, dynamic>),
      json['propertyId'] as String,
      $enumDecode(_$SeverityTypeEnumMap, json['severity']),
      $enumDecode(_$MaintenanceRequestStatusEnumMap, json['status']),
      json['item'] as String,
      json['location'] as String,
      json['description'] as String,
      DateTime.parse(json['submissionDate'] as String),
    )
      ..statusMessage = json['statusMessage'] as String?
      ..projectedCompletionDate = json['projectedCompletionDate'] == null
          ? null
          : DateTime.parse(json['projectedCompletionDate'] as String)
      ..completionDate = json['completionDate'] == null
          ? null
          : DateTime.parse(json['completionDate'] as String)
      ..cancellationDate = json['cancellationDate'] == null
          ? null
          : DateTime.parse(json['cancellationDate'] as String);

Map<String, dynamic> _$MaintenanceRequestToJson(MaintenanceRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leaseAgreementId': instance.leaseAgreementId,
      'createdBy': instance.createdBy.toJson(),
      'propertyId': instance.propertyId,
      'severity': _$SeverityTypeEnumMap[instance.severity],
      'status': _$MaintenanceRequestStatusEnumMap[instance.status],
      'statusMessage': instance.statusMessage,
      'item': instance.item,
      'location': instance.location,
      'description': instance.description,
      'submissionDate': instance.submissionDate.toIso8601String(),
      'projectedCompletionDate':
          instance.projectedCompletionDate?.toIso8601String(),
      'completionDate': instance.completionDate?.toIso8601String(),
      'cancellationDate': instance.cancellationDate?.toIso8601String(),
    };

const _$SeverityTypeEnumMap = {
  SeverityType.None: 0,
  SeverityType.Low: 1,
  SeverityType.Medium: 2,
  SeverityType.High: 3,
  SeverityType.Emergency: 4,
};

const _$MaintenanceRequestStatusEnumMap = {
  MaintenanceRequestStatus.Submitted: 0,
  MaintenanceRequestStatus.Viewed: 1,
  MaintenanceRequestStatus.InProgress: 2,
  MaintenanceRequestStatus.Completed: 3,
  MaintenanceRequestStatus.Cancelled: 4,
};
