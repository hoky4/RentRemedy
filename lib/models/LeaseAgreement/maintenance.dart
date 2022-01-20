import 'package:json_annotation/json_annotation.dart';

enum Maintenance
{
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