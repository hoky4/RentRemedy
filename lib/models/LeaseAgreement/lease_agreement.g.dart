// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lease_agreement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaseAgreement _$LeaseAgreementFromJson(Map<String, dynamic> json) =>
    LeaseAgreement(
      json['id'] as String,
      json['shortId'] as String,
      json['name'] as String,
      json['description'] as String,
      User.fromJson(json['landlord'] as Map<String, dynamic>),
      json['tenant'] == null
          ? null
          : User.fromJson(json['tenant'] as Map<String, dynamic>),
      (json['signatures'] as List<dynamic>)
          .map((e) => Signature.fromJson(e as Map<String, dynamic>))
          .toList(),
      DateTime.parse(json['startDate'] as String),
      DateTime.parse(json['endDate'] as String),
      $enumDecode(_$StatusEnumMap, json['status']),
      json['property'] == null
          ? null
          : Property.fromJson(json['property'] as Map<String, dynamic>),
      OneTimeSecurityDeposit.fromJson(
          json['securityDeposit'] as Map<String, dynamic>),
      MonthlyFees.fromJson(json['monthlyFees'] as Map<String, dynamic>),
      (json['amenitiesProvided'] as List<dynamic>)
          .map((e) => $enumDecode(_$AmenityEnumMap, e))
          .toList(),
      (json['utilitiesProvided'] as List<dynamic>)
          .map((e) => $enumDecode(_$UtilityEnumMap, e))
          .toList(),
      (json['maintenanceProvided'] as List<dynamic>)
          .map((e) => $enumDecode(_$MaintenanceEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$LeaseAgreementToJson(LeaseAgreement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shortId': instance.shortId,
      'name': instance.name,
      'description': instance.description,
      'landlord': instance.landlord.toJson(),
      'tenant': instance.tenant?.toJson(),
      'signatures': instance.signatures.map((e) => e.toJson()).toList(),
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'status': _$StatusEnumMap[instance.status],
      'property': instance.property?.toJson(),
      'securityDeposit': instance.securityDeposit.toJson(),
      'monthlyFees': instance.monthlyFees.toJson(),
      'amenitiesProvided':
          instance.amenitiesProvided.map((e) => _$AmenityEnumMap[e]).toList(),
      'utilitiesProvided':
          instance.utilitiesProvided.map((e) => _$UtilityEnumMap[e]).toList(),
      'maintenanceProvided': instance.maintenanceProvided
          .map((e) => _$MaintenanceEnumMap[e])
          .toList(),
    };

const _$StatusEnumMap = {
  Status.Incomplete: 0,
  Status.Inactive: 1,
  Status.Unassigned: 2,
  Status.AssignedUnsigned: 3,
  Status.AssignedSigned: 4,
  Status.Completed: 5,
  Status.Terminated: 6,
};

const _$AmenityEnumMap = {
  Amenity.Refrigerator: 0,
  Amenity.Microwave: 1,
  Amenity.Stove: 2,
  Amenity.Oven: 3,
  Amenity.Dishwasher: 4,
  Amenity.Washer: 5,
  Amenity.Dryer: 6,
};

const _$UtilityEnumMap = {
  Utility.Electricity: 0,
  Utility.Gas: 1,
  Utility.Water: 2,
  Utility.Internet: 3,
  Utility.Waste: 4,
};

const _$MaintenanceEnumMap = {
  Maintenance.Foundation: 0,
  Maintenance.Plumbing: 1,
  Maintenance.Roof: 2,
  Maintenance.Sprinklers: 3,
  Maintenance.HVAC: 4,
  Maintenance.MainSystems: 5,
  Maintenance.ElectricalSystems: 6,
  Maintenance.Structures: 7,
};
