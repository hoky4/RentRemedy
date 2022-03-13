import 'package:json_annotation/json_annotation.dart';

import '../Property/address.dart';

part 'terminate_lease_agreement_request.g.dart';

@JsonSerializable(explicitToJson: true)
class TerminateLeaseAgreementRequest {
  TerminateLeaseAgreementRequest(
      this.terminationDate, this.reason, this.newAddress);

  String terminationDate;
  String reason;
  Address newAddress;

  factory TerminateLeaseAgreementRequest.fromJson(Map<String, dynamic> json) =>
      _$TerminateLeaseAgreementRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TerminateLeaseAgreementRequestToJson(this);
}
