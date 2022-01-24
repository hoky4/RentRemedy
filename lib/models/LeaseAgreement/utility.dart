import 'package:json_annotation/json_annotation.dart';

enum Utility {
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

extension UtilityExtension on Utility {
  String get value {
    switch (this) {
      case Utility.Electricity:
        return "Electricity";
      case Utility.Gas:
        return "Gas";
      case Utility.Water:
        return "Water";
      case Utility.Internet:
        return "Internet";
      case Utility.Waste:
        return "Waste";
      default:
        return "";
    }
  }
}
