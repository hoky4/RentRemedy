// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      json['id'] as String,
      $enumDecode(_$MessageTypeEnumMap, json['type']),
      json['sender'] as String,
      json['recipient'] as String,
      json['sentFromSystem'] as bool,
      DateTime.parse(json['creationDate'] as String),
      json['messageText'] as String,
      json['messageTempId'] as String,
      json['readDate'] == null
          ? null
          : DateTime.parse(json['readDate'] as String),
      json['actionId'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumMap[instance.type],
      'sender': instance.sender,
      'recipient': instance.recipient,
      'sentFromSystem': instance.sentFromSystem,
      'creationDate': instance.creationDate.toIso8601String(),
      'messageText': instance.messageText,
      'messageTempId': instance.messageTempId,
      'readDate': instance.readDate?.toIso8601String(),
      'actionId': instance.actionId,
    };

const _$MessageTypeEnumMap = {
  MessageType.Text: 0,
  MessageType.PaymentDue: 1,
  MessageType.PaymentReceived: 2,
};
