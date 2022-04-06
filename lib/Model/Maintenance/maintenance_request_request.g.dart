// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_request_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaintenanceRequestRequest _$MaintenanceRequestRequestFromJson(
        Map<String, dynamic> json) =>
    MaintenanceRequestRequest(
      json['leaseAgreementId'] as String,
      json['propertyId'] as String,
      $enumDecode(_$SeverityTypeEnumMap, json['severity']),
      json['item'] as String,
      json['location'] as String,
      json['description'] as String,
      json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      (json['imageIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MaintenanceRequestRequestToJson(
        MaintenanceRequestRequest instance) =>
    <String, dynamic>{
      'leaseAgreementId': instance.leaseAgreementId,
      'propertyId': instance.propertyId,
      'severity': _$SeverityTypeEnumMap[instance.severity],
      'item': instance.item,
      'location': instance.location,
      'description': instance.description,
      'dateTime': instance.dateTime?.toIso8601String(),
      'imageIds': instance.imageIds,
    };

const _$SeverityTypeEnumMap = {
  SeverityType.None: 0,
  SeverityType.Low: 1,
  SeverityType.Medium: 2,
  SeverityType.High: 3,
  SeverityType.Emergency: 4,
};
