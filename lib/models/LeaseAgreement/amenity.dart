import 'package:json_annotation/json_annotation.dart';

enum Amenity //extends Iterable
{
  @JsonValue(0)
  Refrigerator,
  @JsonValue(1)
  Microwave,
  @JsonValue(2)
  Stove,
  @JsonValue(3)
  Oven,
  @JsonValue(4)
  Dishwasher,
  @JsonValue(5)
  Washer,
  @JsonValue(6)
  Dryer
}