// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      json['id'] as String,
      json['reviewerId'] as String?,
      json['revieweeId'] as String?,
      json['score'] as int,
      json['description'] as String?,
      $enumDecode(_$ReviewStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
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
