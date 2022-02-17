import 'package:json_annotation/json_annotation.dart';
part 'one_time_security_deposit.g.dart';

@JsonSerializable()
class OneTimeSecurityDeposit {
  OneTimeSecurityDeposit(this.depositAmount, this.refundAmount, this.dueDate);

  double depositAmount;
  double refundAmount;
  DateTime dueDate;

  factory OneTimeSecurityDeposit.fromJson(Map<String, dynamic> json) => _$OneTimeSecurityDepositFromJson(json);

  Map<String, dynamic> toJson() => _$OneTimeSecurityDepositToJson(this);
}