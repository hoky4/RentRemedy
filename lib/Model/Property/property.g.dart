// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      json['id'] as String,
      json['name'] as String,
      json['description'] as String,
      Address.fromJson(json['address'] as Map<String, dynamic>),
      (json['leaseAgreements'] as List<dynamic>)
          .map((e) => ViewLeaseAgreement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'address': instance.address.toJson(),
      'leaseAgreements':
          instance.leaseAgreements.map((e) => e.toJson()).toList(),
    };
