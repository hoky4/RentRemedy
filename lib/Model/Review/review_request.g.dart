// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewRequest _$ReviewRequestFromJson(Map<String, dynamic> json) =>
    ReviewRequest(
      json['reviewerId'] as String,
      json['revieweeId'] as String,
      json['score'] as int,
      json['description'] as String,
      $enumDecode(_$ReviewStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$ReviewRequestToJson(ReviewRequest instance) =>
    <String, dynamic>{
      'reviewerId': instance.reviewerId,
      'revieweeId': instance.revieweeId,
      'score': instance.score,
      'description': instance.description,
      'status': _$ReviewStatusEnumMap[instance.status],
    };

const _$ReviewStatusEnumMap = {
  ReviewStatus.Pending: 0,
  ReviewStatus.Rejected: 1,
  ReviewStatus.FilledOut: 2,
};
