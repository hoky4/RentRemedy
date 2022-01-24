import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/models/Fees/due_date_type.dart';
import 'package:rentremedy_mobile/models/Fees/monthly_pet_fee.dart';
import 'monthly_rent_fee.dart';
part 'monthly_fees.g.dart';

@JsonSerializable(explicitToJson: true)
class MonthlyFees {
  MonthlyFees(this.rentFee, this.petFee, this.dueDateType, this.dueDate, this.lateFee, this.gracePeriod);

  MonthlyRentFee rentFee;
  MonthlyPetFee petFee;
  DueDateType dueDateType;
  DateTime? dueDate;
  double lateFee;
  int gracePeriod;

  factory MonthlyFees.fromJson(Map<String, dynamic> json) => _$MonthlyFeesFromJson(json);
  Map<String, dynamic> toJson() => _$MonthlyFeesToJson(this);
}
