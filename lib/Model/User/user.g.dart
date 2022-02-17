// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
      (json['roles'] as List<dynamic>)
          .map((e) => $enumDecode(_$RoleEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'roles': instance.roles.map((e) => _$RoleEnumMap[e]).toList(),
    };

const _$RoleEnumMap = {
  Role.Tenant: 0,
  Role.Landlord: 1,
};
