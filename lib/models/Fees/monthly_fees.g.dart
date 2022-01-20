// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_fees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyFees _$MonthlyFeesFromJson(Map<String, dynamic> json) => MonthlyFees(
      MonthlyRentFee.fromJson(json['rentFee'] as Map<String, dynamic>),
      MonthlyPetFee.fromJson(json['petFee'] as Map<String, dynamic>),
      $enumDecode(_$DueDateTypeEnumMap, json['dueDateType']),
      json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      (json['lateFee'] as num).toDouble(),
      json['gracePeriod'] as int,
    );

Map<String, dynamic> _$MonthlyFeesToJson(MonthlyFees instance) =>
    <String, dynamic>{
      'rentFee': instance.rentFee.toJson(),
      'petFee': instance.petFee.toJson(),
      'dueDateType': _$DueDateTypeEnumMap[instance.dueDateType],
      'dateTime': instance.dateTime?.toIso8601String(),
      'lateFee': instance.lateFee,
      'gracePeriod': instance.gracePeriod,
    };

const _$DueDateTypeEnumMap = {
  DueDateType.StartOfMonth: 0,
  DueDateType.EndOfMonth: 1,
  DueDateType.DayOfMonth: 2,
};
