import 'dart:core';

class LeaseAgreement {
  late String id;
  late String shortId;
  late String name;
  late String description;
  late String landlord;
  late String tenant;
  late Map<String, String> signatures;
  late String startDate;
  late String endDate;
  late Map<String, dynamic> fees;

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
    // print('json: $json');
    Map<String, dynamic> leaseAgreement = json['leaseAgreements'][0];
    // print('la-id: ${leaseAgreement['id']}');
    // leaseAgreement.forEach((element) {
    //   print('element-type: ${element.runtimeType}');
    //   print('item: $element,\ntype: ${element.runtimeType}');
    // });

    this.id = leaseAgreement['id'].toString();

    this.shortId = leaseAgreement['shortId'].toString();
    this.name = leaseAgreement['name'].toString();
    this.description = leaseAgreement['description'].toString();
    this.landlord = leaseAgreement['landlord'].toString();
    this.tenant = leaseAgreement['tenant'].toString();
    this.signatures = leaseAgreement['signatures'];
    // print('signatures-type: ${leaseAgreement['signatures'].runtimeType}');
    // if (leaseAgreement['signatures'] != null) {
    // leaseAgreement['signatures'].forEach((k, v) {
    //   print('key: $k, value: $v');
    //   signatures[k] = v;
    // });
    // }

    // print('signatures: $signatures');
    this.startDate = leaseAgreement['startDate'].toString();
    this.endDate = leaseAgreement['endDate'].toString();
    this.fees = {};
    // print('fees-type: ${leaseAgreement['fees'][0].runtimeType}');

    Map<String, dynamic> leaseAgreementFees = leaseAgreement['fees'][0];
    leaseAgreementFees.forEach((k, v) {
      // print('key: $k, value: $v');
      fees[k] = v;
    });
    // print('fees: $fees');
  }
}
