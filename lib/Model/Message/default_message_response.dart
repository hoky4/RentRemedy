import 'package:rentremedy_mobile/Model/Message/messaging_socket_response.dart';

import 'message_type.dart';

abstract class DefaultMessageResponse implements MessagingSocketResponse {
  DefaultMessageResponse(this.id, this.type, this.sender, this.recipient, this.sentFromSystem, this.creationDate, this.readDate);
  
  String id;
  MessageType type;
  String sender;
  String recipient;
  bool sentFromSystem;
  DateTime creationDate;
  DateTime? readDate;
}