import 'package:rentremedy_mobile/Model/LeaseAgreement/status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'view_lease_agreement.g.dart';

@JsonSerializable()
class ViewLeaseAgreement{
  String id;
  String name;
  String description;
  Status status;

  factory ViewLeaseAgreement.fromJson(Map<String, dynamic> json) =>
      _$ViewLeaseAgreementFromJson(json);

  Map<String, dynamic> toJson() => _$ViewLeaseAgreementToJson(this);

  ViewLeaseAgreement(this.id, this.name, this.description, this.status);
}