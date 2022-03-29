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
      json['messageTempId'] as String?,
      json['readDate'] == null
          ? null
          : DateTime.parse(json['readDate'] as String),
      json['actionId'] as String?,
      json['media'] == null
          ? null
          : BucketObject.fromJson(json['media'] as Map<String, dynamic>),
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
      'media': instance.media?.toJson(),
    };

const _$MessageTypeEnumMap = {
  MessageType.Text: 0,
  MessageType.PaymentDue: 1,
  MessageType.PaymentSuccessful: 2,
  MessageType.PaymentProcessing: 3,
  MessageType.PaymentReceived: 4,
  MessageType.WelcomeMessage: 5,
  MessageType.MaintenanceCreated: 6,
  MessageType.MaintenanceCompleted: 7,
  MessageType.MaintenanceCancelled: 8,
  MessageType.MaintenanceUpdated: 9,
  MessageType.TerminationNotification: 10,
};
