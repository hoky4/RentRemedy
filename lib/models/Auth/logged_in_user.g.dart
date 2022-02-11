// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_in_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggedInUser _$LoggedInUserFromJson(Map<String, dynamic> json) => LoggedInUser(
      json['id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
      (json['roles'] as List<dynamic>)
          .map((e) => $enumDecode(_$RoleEnumMap, e))
          .toList(),
      json['landlordId'] as String,
      json['cookie'] as String,
    );

Map<String, dynamic> _$LoggedInUserToJson(LoggedInUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'roles': instance.roles.map((e) => _$RoleEnumMap[e]).toList(),
      'landlordId': instance.landlordId,
      'cookie': instance.cookie,
    };

const _$RoleEnumMap = {
  Role.Tenant: 0,
  Role.Landlord: 1,
};
