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
      json['cookie'] as String?,
      json['leaseAgreement'] == null
          ? null
          : LeaseAgreement.fromJson(
              json['leaseAgreement'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoggedInUserToJson(LoggedInUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'roles': instance.roles.map((e) => _$RoleEnumMap[e]).toList(),
      'cookie': instance.cookie,
      'leaseAgreement': instance.leaseAgreement?.toJson(),
    };

const _$RoleEnumMap = {
  Role.Tenant: 0,
  Role.Landlord: 1,
};
