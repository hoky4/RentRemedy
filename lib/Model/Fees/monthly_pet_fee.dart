import 'package:json_annotation/json_annotation.dart';
part 'monthly_pet_fee.g.dart';

@JsonSerializable()
class MonthlyPetFee {
  MonthlyPetFee(this.petsAllowed, this.petFeeAmount);

  bool petsAllowed;
  // bool? tenantHasPet;
  double petFeeAmount;

  factory MonthlyPetFee.fromJson(Map<String, dynamic> json) => _$MonthlyPetFeeFromJson(json);
  Map<String, dynamic> toJson() => _$MonthlyPetFeeToJson(this);
}