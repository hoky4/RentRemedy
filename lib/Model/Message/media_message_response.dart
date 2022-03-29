import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Media/bucket_object.dart';
import 'package:rentremedy_mobile/Model/Message/default_message_response.dart';
import 'package:rentremedy_mobile/Model/Message/messaging_socket_response.dart';
import 'package:rentremedy_mobile/Model/Message/message_type.dart';

part 'media_message_response.g.dart';

@JsonSerializable()
class MediaMessageResponse implements DefaultMessageResponse {
  MediaMessageResponse(this.media, this.creationDate, this.id, this.model, this.readDate, this.recipient, this.sender, this.sentFromSystem, this.type);
  
  BucketObject media;
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
  
  factory MediaMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MediaMessageResponseFromJson(json);
      
  Map<String, dynamic> toJson() => _$MediaMessageResponseToJson(this);
  }