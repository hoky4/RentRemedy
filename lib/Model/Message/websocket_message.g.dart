// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSocketMessage _$WebSocketMessageFromJson(Map<String, dynamic> json) =>
    WebSocketMessage(
      json['recipient'] as String,
      json['messageText'] as String,
      json['messageTempId'] as String,
      $enumDecode(_$ModelEnumMap, json['model']),
    );

Map<String, dynamic> _$WebSocketMessageToJson(WebSocketMessage instance) =>
    <String, dynamic>{
      'recipient': instance.recipient,
      'messageText': instance.messageText,
      'messageTempId': instance.messageTempId,
      'model': _$ModelEnumMap[instance.model],
    };

const _$ModelEnumMap = {
  Model.Message: 0,
  Model.MessageDelivered: 1,
  Model.MessageRead: 2,
};
