import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/amenity.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/maintenance.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/one_time_security_deposit.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/utility.dart';
import 'package:rentremedy_mobile/models/Property/property.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/signature.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/status.dart';
import 'package:rentremedy_mobile/models/User/user.dart';
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
      this.status,
      this.property,
      this.securityDeposit,
      this.amenitiesProvided,
      this.utilitiesProvided,
      this.maintenanceProvided
      );

  String id;
  String shortId;
  String name;
  String description;
  User landlord;
  User? tenant;
  List<Signature> signatures;
  DateTime startDate;
  DateTime endDate;
  Status status;
  Property property;
  OneTimeSecurityDeposit securityDeposit;
  List<Amenity> amenitiesProvided;
  List<Utility> utilitiesProvided;
  List<Maintenance> maintenanceProvided;
  
  factory LeaseAgreement.fromJson(Map<String, dynamic> json) =>
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
