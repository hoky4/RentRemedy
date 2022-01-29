// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Messages _$MessagesFromJson(Map<String, dynamic> json) => Messages(
      json['recipient'] as String,
      json['messageText'] as String,
      json['messageTempId'] as String,
      $enumDecode(_$ModelEnumMap, json['model']),
    );

Map<String, dynamic> _$MessagesToJson(Messages instance) => <String, dynamic>{
      'recipient': instance.recipient,
      'messageText': instance.messageText,
      'messageTempId': instance.messageTempId,
      'model': _$ModelEnumMap[instance.model],
    };

const _$ModelEnumMap = {
  Model.Message: 1,
  Model.MessageDelivered: 2,
  Model.MessageRead: 3,
};
