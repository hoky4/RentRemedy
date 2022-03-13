// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termination_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminationInfo _$TerminationInfoFromJson(Map<String, dynamic> json) =>
    TerminationInfo(
      json['terminationPaymentId'] as String?,
      json['terminationFee'] as int,
      json['terminationDate'] == null
          ? null
          : DateTime.parse(json['terminationDate'] as String),
      json['reason'] as String?,
      json['newAddress'] == null
          ? null
          : Address.fromJson(json['newAddress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TerminationInfoToJson(TerminationInfo instance) =>
    <String, dynamic>{
      'terminationPaymentId': instance.terminationPaymentId,
      'terminationFee': instance.terminationFee,
      'terminationDate': instance.terminationDate?.toIso8601String(),
      'reason': instance.reason,
      'newAddress': instance.newAddress?.toJson(),
    };
