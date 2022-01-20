import 'package:json_annotation/json_annotation.dart';
import 'address.dart';
part 'property.g.dart';

@JsonSerializable(explicitToJson: true)
class Property {
  Property(this.id, this.name, this.description, this.address, this.leaseAgreements);

  String id;
  String name;
  String description;
  Address address;
  List<String> leaseAgreements;

  factory Property.fromJson(Map<String, dynamic> json) => _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}