// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup_intent_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetupIntentRequest _$SetupIntentRequestFromJson(Map<String, dynamic> json) =>
    SetupIntentRequest(
      json['type'] as String,
      json['number'] as String,
      json['expMonth'] as int,
      json['expYear'] as int,
      json['cvc'] as String,
    );

Map<String, dynamic> _$SetupIntentRequestToJson(SetupIntentRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'number': instance.number,
      'expMonth': instance.expMonth,
      'expYear': instance.expYear,
      'cvc': instance.cvc,
    };
