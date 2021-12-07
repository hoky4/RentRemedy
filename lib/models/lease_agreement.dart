import 'dart:core';

class LeaseAgreement {
  late String id;
  late String shortId;
  late String name;
  late String description;
  late String landlord;
  late String tenant;
  late List<String> signatures;
  late String startDate;
  late String endDate;
  late List<dynamic> fees;

  LeaseAgreement({
    required this.id,
    required this.shortId,
    required this.name,
    required this.description,
    required this.landlord,
    required this.tenant,
    required this.signatures,
    required this.startDate,
    required this.endDate,
    required this.fees,
  });

  LeaseAgreement.fromJson(Map<String, dynamic> json) {
    this.id = json['id'].toString();
    this.shortId = json['shortId'].toString();
    this.name = json['name'].toString();
    this.description = json['description'].toString();
    this.landlord = json['landlord'].toString();
    this.tenant = json['tenant'].toString();
    this.signatures = <String>[];
    json['fees'].forEach((v) {
      signatures.add(v);
    });
    this.startDate = json['startDate'].toString();
    this.endDate = json['endDate'].toString();
    this.fees = <dynamic>[];
    json['results'].forEach((v) {
      signatures.add(v);
    });
  }
}
