// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Signature _$SignatureFromJson(Map<String, dynamic> json) => Signature(
      json['signer'] as String,
      DateTime.parse(json['signDate'] as String),
    );

Map<String, dynamic> _$SignatureToJson(Signature instance) => <String, dynamic>{
      'signer': instance.signer,
      'signDate': instance.signDate.toIso8601String(),
    };
