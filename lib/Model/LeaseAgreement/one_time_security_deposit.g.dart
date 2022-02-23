// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_time_security_deposit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneTimeSecurityDeposit _$OneTimeSecurityDepositFromJson(
        Map<String, dynamic> json) =>
    OneTimeSecurityDeposit(
      (json['depositAmount'] as num).toDouble(),
      (json['refundAmount'] as num).toDouble(),
      DateTime.parse(json['dueDate'] as String),
    );

Map<String, dynamic> _$OneTimeSecurityDepositToJson(
        OneTimeSecurityDeposit instance) =>
    <String, dynamic>{
      'depositAmount': instance.depositAmount,
      'refundAmount': instance.refundAmount,
      'dueDate': instance.dueDate.toIso8601String(),
    };
