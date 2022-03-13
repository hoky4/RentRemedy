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
      json['lateFee'] as int,
      json['isLateFeeForgiven'] as bool?,
      json['isPaymentForgiven'] as bool?,
      $enumDecode(_$PaymentStatusEnumMap, json['status']),
      DateTime.parse(json['dueDate'] as String),
      json['paymentDate'] == null
          ? null
          : DateTime.parse(json['paymentDate'] as String),
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'leaseAgreement': instance.leaseAgreement.toJson(),
      'payer': instance.payer.toJson(),
      'chargeAmount': instance.chargeAmount,
      'paidAmount': instance.paidAmount,
      'lateFee': instance.lateFee,
      'isLateFeeForgiven': instance.isLateFeeForgiven,
      'isPaymentForgiven': instance.isPaymentForgiven,
      'status': _$PaymentStatusEnumMap[instance.status],
      'dueDate': instance.dueDate.toIso8601String(),
      'paymentDate': instance.paymentDate?.toIso8601String(),
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.Pending: 0,
  PaymentStatus.Late: 1,
  PaymentStatus.Paid: 2,
  PaymentStatus.PaidLate: 3,
  PaymentStatus.Forgiven: 4,
  PaymentStatus.Submitted: 5,
  PaymentStatus.SubmittedLate: 6,
  PaymentStatus.Terminated: 7,
};
