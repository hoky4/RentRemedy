// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      json['id'] as String,
      LeaseAgreement.fromJson(json['leaseAgreement'] as Map<String, dynamic>),
      User.fromJson(json['payer'] as Map<String, dynamic>),
      json['chargeAmount'] as int,
      json['paidAmount'] as int,
      json['isLate'] as bool,
      json['isLateFeeForgiven'] as bool?,
      json['isPaymentForgiven'] as bool?,
      DateTime.parse(json['dueDate'] as String),
      json['paymentDate'] == null
          ? null
          : DateTime.parse(json['paymentDate'] as String),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'leaseAgreement': instance.leaseAgreement,
      'payer': instance.payer,
      'chargeAmount': instance.chargeAmount,
      'paidAmount': instance.paidAmount,
      'isLate': instance.isLate,
      'isLateFeeForgiven': instance.isLateFeeForgiven,
      'isPaymentForgiven': instance.isPaymentForgiven,
      'dueDate': instance.dueDate.toIso8601String(),
      'paymentDate': instance.paymentDate?.toIso8601String(),
    };
