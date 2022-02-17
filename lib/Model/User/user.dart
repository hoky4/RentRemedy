import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/User/role.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  User(this.id, this.firstName, this.lastName, this.email, this.roles);

  String id;
  String firstName;
  String lastName;
  String email;
  List<Role> roles;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
