import 'package:json_annotation/json_annotation.dart';

enum Utility
{
  @JsonValue(0)
  Electricity,
  @JsonValue(1)
  Gas,
  @JsonValue(2)
  Water,
  @JsonValue(3)
  Internet,
  @JsonValue(4)
  Waste
}