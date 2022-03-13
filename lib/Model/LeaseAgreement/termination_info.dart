import 'package:json_annotation/json_annotation.dart';

import '../Property/address.dart';

part 'termination_info.g.dart';

@JsonSerializable(explicitToJson: true)
class TerminationInfo {
  TerminationInfo(this.terminationPaymentId, this.terminationFee,
      this.terminationDate, this.reason, this.newAddress);

  String? terminationPaymentId;
  int terminationFee;
  DateTime? terminationDate;
  String? reason;
  Address? newAddress;

  factory TerminationInfo.fromJson(Map<String, dynamic> json) =>
      _$TerminationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TerminationInfoToJson(this);
}
