import 'package:json_annotation/json_annotation.dart';

enum Role{
  @JsonValue(0)
  Tenant,
  @JsonValue(1)
  Landlord
}