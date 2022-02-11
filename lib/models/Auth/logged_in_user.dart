import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/models/User/role.dart';
part 'logged_in_user.g.dart';

@JsonSerializable(explicitToJson: true)
class LoggedInUser {
  LoggedInUser(
    this.id, 
    this.firstName, 
    this.lastName, 
    this.email, 
    this.roles, 
    this.landlordId, 
    this.cookie);

  String id;
  String firstName;
  String lastName;
  String email;
  List<Role> roles;
  String landlordId;
  String cookie;

  factory LoggedInUser.fromJson(Map<String, dynamic> json) =>
      _$LoggedInUserFromJson(json);

  Map<String, dynamic> toJson() => _$LoggedInUserToJson(this);
}
