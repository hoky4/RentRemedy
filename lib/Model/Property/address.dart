import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class Address {
  Address(this.line1, this.line2, this.city, this.state, this.zipCode, this.tag);

  String line1;
  String line2;
  String city;
  String state;
  String zipCode;
  String tag;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}