import 'package:json_annotation/json_annotation.dart';

enum Maintenance {
  @JsonValue(0)
  Foundation,
  @JsonValue(1)
  Plumbing,
  @JsonValue(2)
  Roof,
  @JsonValue(3)
  Sprinklers,
  @JsonValue(4)
  HVAC,
  @JsonValue(5)
  MainSystems,
  @JsonValue(6)
  ElectricalSystems,
  @JsonValue(7)
  Structures,
}

extension MaintenanceExtension on Maintenance {
  String get value {
    switch (this) {
      case Maintenance.Foundation:
        return "Foundation";
      case Maintenance.Plumbing:
        return "Plumbing";
      case Maintenance.Roof:
        return "Roof";
      case Maintenance.Sprinklers:
        return "Sprinklers";
      case Maintenance.HVAC:
        return "HVAC";
      case Maintenance.MainSystems:
        return "Main Systems";
      case Maintenance.ElectricalSystems:
        return "Electrical Systems";
      case Maintenance.Structures:
        return "Structures";
      default:
        return "";
    }
  }
}
