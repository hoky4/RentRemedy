// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_pet_fee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyPetFee _$MonthlyPetFeeFromJson(Map<String, dynamic> json) =>
    MonthlyPetFee(
      json['petsAllowed'] as bool,
      (json['petFeeAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$MonthlyPetFeeToJson(MonthlyPetFee instance) =>
    <String, dynamic>{
      'petsAllowed': instance.petsAllowed,
      'petFeeAmount': instance.petFeeAmount,
    };
