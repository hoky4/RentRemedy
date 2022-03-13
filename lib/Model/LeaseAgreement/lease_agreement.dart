import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Fees/monthly_fees.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/amenity.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/maintenance.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/one_time_security_deposit.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/termination_info.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/utility.dart';
import 'package:rentremedy_mobile/Model/Property/property.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/signature.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/status.dart';
import 'package:rentremedy_mobile/Model/User/user.dart';
part 'lease_agreement.g.dart';

@JsonSerializable(explicitToJson: true)
class LeaseAgreement {
  LeaseAgreement(
      this.id,
      this.shortId,
      this.name,
      this.description,
      this.landlord,
      this.tenant,
      this.signatures,
      this.startDate,
      this.endDate,
      this.actualEndDate,
      this.status,
      this.property,
      this.terminationInfo,
      this.securityDeposit,
      this.monthlyFees,
      this.amenitiesProvided,
      this.utilitiesProvided,
      this.maintenanceProvided);

  String id;
  String shortId;
  String name;
  String description;
  User landlord;
  User? tenant;
  List<Signature> signatures;
  DateTime startDate;
  DateTime endDate;
  DateTime? actualEndDate;
  Status status;
  Property? property;
  TerminationInfo? terminationInfo;
  OneTimeSecurityDeposit securityDeposit;
  MonthlyFees monthlyFees;
  List<Amenity> amenitiesProvided;
  List<Utility> utilitiesProvided;
  List<Maintenance> maintenanceProvided;

  factory LeaseAgreement.fromJson(Map<String, dynamic?> json) =>
      _$LeaseAgreementFromJson(json);

  Map<String, dynamic> toJson() => _$LeaseAgreementToJson(this);
}
/*
  @override
  String toString() {
    return 'Name: $name,\n'
        'Description: $description,\n'
        'Start Date: $startDate,\n'
        'End Date: $endDate,\n'
        '\nFees: \n  Name: ${fees['name']},\n  Description: ${fees['description']},\n  Amount: ${fees['amount']}\n'
        '\nProperty: \n  Name: ${property['name']},\n  Description: ${property['description']},\n\nAddress: \n   ${property['address']['line1']} ${property['address']['line2']}\n   ${property['address']['city']}, ${property['address']['state']} ${property['address']['zipCode']}';
  }
*/
