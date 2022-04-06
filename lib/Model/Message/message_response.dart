import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Message/default_message_response.dart';
import 'package:rentremedy_mobile/Model/Message/messaging_socket_response.dart';
import 'package:rentremedy_mobile/Model/Message/message_type.dart';

part 'message_response.g.dart';

@JsonSerializable()
class MessageResponse implements DefaultMessageResponse {
  MessageResponse(this.messageText, this.actionId, this.creationDate, this.id, this.model, this.readDate, this.recipient, this.sender, this.sentFromSystem, this.type);
  
  String messageText;
  String? actionId;
  @override
  DateTime creationDate;
  @override
  String id;
  @override
  MessagingSocketResponseModelType model;
  @override
  DateTime? readDate;
  @override
  String recipient;
  @override
  String sender;
  @override
  bool sentFromSystem;
  @override
  MessageType type;
  
factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$MessageResponseToJson(this);

  }