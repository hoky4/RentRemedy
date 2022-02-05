// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentIntentResponse _$PaymentIntentResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentIntentResponse(
      Payment.fromJson(json['payment'] as Map<String, dynamic>),
      json['status'] as String,
    );

Map<String, dynamic> _$PaymentIntentResponseToJson(
        PaymentIntentResponse instance) =>
    <String, dynamic>{
      'payment': instance.payment.toJson(),
      'status': instance.status,
    };
