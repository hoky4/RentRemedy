import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Message/messaging_socket_response.dart';

part 'message_delivered_response.g.dart';


@JsonSerializable()
class MessageDeliveredResponse implements MessagingSocketResponse {
  @override
  MessagingSocketResponseModelType model;
  String messageId;
  String messageTempId;
  DateTime messageDeliveredDate;

  factory MessageDeliveredResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageDeliveredResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDeliveredResponseToJson(this);

  MessageDeliveredResponse(this.messageDeliveredDate, this.messageId, this.messageTempId, this.model);
}