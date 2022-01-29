import 'package:json_annotation/json_annotation.dart';

enum Model {
  @JsonValue(1)
  Message,
  @JsonValue(2)
  MessageDelivered,
  @JsonValue(3)
  MessageRead,
}
