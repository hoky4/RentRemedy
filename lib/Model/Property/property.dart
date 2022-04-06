import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/view_lease_agreement.dart';
import 'address.dart';
part 'property.g.dart';

@JsonSerializable(explicitToJson: true)
class Property {
  Property(this.id, this.name, this.description, this.address, this.leaseAgreements);

  String id;
  String name;
  String description;
  Address address;
  List<ViewLeaseAgreement> leaseAgreements;

  factory Property.fromJson(Map<String, dynamic> json) => _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);

  @override 
String toString() {
  return "${address.line1} ${address.line2}\n${address.city}, ${address.state} ${address.zipCode}";
  }
}

