import 'package:json_annotation/json_annotation.dart';

enum Model {
  @JsonValue(0)
  Message,
  @JsonValue(1)
  MessageDelivered,
  @JsonValue(2)
  MessageRead,
}
