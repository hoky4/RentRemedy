import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Model/User/role.dart';
part 'logged_in_user.g.dart';

@JsonSerializable(explicitToJson: true)
class LoggedInUser {
  LoggedInUser(this.id, this.firstName, this.lastName, this.email, this.roles,
      this.cookie, this.leaseAgreement);

  String id;
  String firstName;
  String lastName;
  String email;
  List<Role> roles;
  String? cookie;
  LeaseAgreement? leaseAgreement;

  factory LoggedInUser.fromJson(Map<String, dynamic> json) =>
      _$LoggedInUserFromJson(json);

  Map<String, dynamic> toJson() => _$LoggedInUserToJson(this);
}
