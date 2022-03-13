// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'terminate_lease_agreement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TerminateLeaseAgreementRequest _$TerminateLeaseAgreementRequestFromJson(
        Map<String, dynamic> json) =>
    TerminateLeaseAgreementRequest(
      json['terminationDate'] as String,
      json['reason'] as String,
      Address.fromJson(json['newAddress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TerminateLeaseAgreementRequestToJson(
        TerminateLeaseAgreementRequest instance) =>
    <String, dynamic>{
      'terminationDate': instance.terminationDate,
      'reason': instance.reason,
      'newAddress': instance.newAddress.toJson(),
    };
