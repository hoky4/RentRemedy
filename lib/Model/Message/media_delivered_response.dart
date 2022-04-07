import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Media/bucket_object.dart';

import 'message_delivered_response.dart';
import 'messaging_socket_response.dart';

part 'media_delivered_response.g.dart';

@JsonSerializable()
class MediaDeliveredResponse implements MessageDeliveredResponse {
  
  BucketObject media;
  @override
  DateTime messageDeliveredDate;
  @override
  String messageId;
  @override
  String messageTempId;
  @override
  MessagingSocketResponseModelType model;
  @override
  factory MediaDeliveredResponse.fromJson(Map<String, dynamic> json) =>
      _$MediaDeliveredResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MediaDeliveredResponseToJson(this);
  MediaDeliveredResponse(this.media, this.messageDeliveredDate, this.messageId, this.messageTempId, this.model);
    
}