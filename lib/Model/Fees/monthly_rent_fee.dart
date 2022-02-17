import 'package:json_annotation/json_annotation.dart';
part 'monthly_rent_fee.g.dart';

@JsonSerializable()
class MonthlyRentFee {
  MonthlyRentFee(this.rentFeeAmount);

  double rentFeeAmount;

  factory MonthlyRentFee.fromJson(Map<String, dynamic> json) => _$MonthlyRentFeeFromJson(json);
  Map<String, dynamic> toJson() => _$MonthlyRentFeeToJson(this);
}
