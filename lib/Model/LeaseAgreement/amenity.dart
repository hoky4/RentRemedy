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

extension AmenityExtension on Amenity {
  String get value {
    switch (this) {
      case Amenity.Refrigerator:
        return "Refrigerator";
      case Amenity.Microwave:
        return "Microwave";
      case Amenity.Stove:
        return "Stove";
      case Amenity.Oven:
        return "Oven";
      case Amenity.Dishwasher:
        return "Dishwasher";
      case Amenity.Washer:
        return "Washer";
      case Amenity.Dryer:
        return "Dryer";
      default:
        return "";
    }
  }
}
