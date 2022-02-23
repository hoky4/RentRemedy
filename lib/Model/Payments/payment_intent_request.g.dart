// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intent_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentIntentRequest _$PaymentIntentRequestFromJson(
        Map<String, dynamic> json) =>
    PaymentIntentRequest(
      json['paymentId'] as String,
      json['paymentMethodId'] as String,
    );

Map<String, dynamic> _$PaymentIntentRequestToJson(
        PaymentIntentRequest instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'paymentMethodId': instance.paymentMethodId,
    };
