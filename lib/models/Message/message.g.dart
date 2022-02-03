// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      sender: json['sender'] as String,
      recipient: json['recipient'] as String,
      sentFromSystem: json['sentFromSystem'] as bool,
      creationDate: DateTime.parse(json['creationDate'] as String),
      messageText: json['messageText'] as String,
      messageTempId: json['messageTempId'] as String?,
      readDate: json['readDate'] == null
          ? null
          : DateTime.parse(json['readDate'] as String),
      actionId: json['actionId'] as String?,
      delivered: json['delivered'] as bool? ?? true,
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
      'delivered': instance.delivered,
    };

const _$MessageTypeEnumMap = {
  MessageType.Text: 0,
  MessageType.PaymentDue: 1,
  MessageType.PaymentReceived: 2,
};
