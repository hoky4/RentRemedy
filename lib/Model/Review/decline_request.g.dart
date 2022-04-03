// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decline_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeclineRequest _$DeclineRequestFromJson(Map<String, dynamic> json) =>
    DeclineRequest(
      json['leaseAgreementId'] as String,
      $enumDecode(_$ReviewStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$DeclineRequestToJson(DeclineRequest instance) =>
    <String, dynamic>{
      'leaseAgreementId': instance.leaseAgreementId,
      'status': _$ReviewStatusEnumMap[instance.status],
    };

const _$ReviewStatusEnumMap = {
  ReviewStatus.Pending: 0,
  ReviewStatus.Rejected: 1,
  ReviewStatus.FilledOut: 2,
};
