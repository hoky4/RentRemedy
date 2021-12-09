import 'dart:core';

class LeaseAgreement {
  late String id;
  late String shortId;
  late String name;
  late String description;
  late Map<String, dynamic> landlord;
  late String tenant;
  late Map<String, dynamic> signatures;
  late String startDate;
  late String endDate;
  late Map<String, dynamic> fees;
  late Map<String, dynamic> property;

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
    required this.property,
  });

  @override
  String toString() {
    return 'Name: $name,\n'
        'Description: $description,\n'
        'Start Date: $startDate,\n'
        'End Date: $endDate,\n'
        '\nFees: \n  Name: ${fees['name']},\n  Description: ${fees['description']},\n  Amount: ${fees['amount']}\n'
        '\nProperty: \n  Name: ${property['name']},\n  Description: ${property['description']},\n\nAddress: \n   ${property['address']['line1']} ${property['address']['line2']}\n   ${property['address']['city']}, ${property['address']['state']} ${property['address']['zipCode']}';
  }

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
    // print('landlord-type: ${leaseAgreement['landlord']}');
    this.landlord = leaseAgreement['landlord'];
    this.tenant = leaseAgreement['tenant'].toString();
    print('signatures-type: ${leaseAgreement['signatures'].runtimeType}');
    List<dynamic> la = leaseAgreement['signatures'];
    if (la.isEmpty) {
      this.signatures = {};
    } else {
      this.signatures = leaseAgreement['signatures'][0];
    }

    // if (leaseAgreement['signatures'] != null) {
    //   leaseAgreement['signatures'].forEach((k, v) {
    //     print('key: $k, value: $v');
    //     signatures[k] = v;
    //   });
    // }

    // print('signatures: $signatures');
    this.startDate = leaseAgreement['startDate'].toString();
    this.endDate = leaseAgreement['endDate'].toString();
    this.fees = leaseAgreement['fees'][0];
    // print('fees-type: ${leaseAgreement['fees'][0].runtimeType}');
    //
    // Map<String, dynamic> leaseAgreementFees = leaseAgreement['fees'][0];
    // leaseAgreementFees.forEach((k, v) {
    //   fees[k] = v;
    // });
    print('property-type: ${leaseAgreement['property'].runtimeType}');
    print('property-type2: ${leaseAgreement['property'][0].runtimeType}');

    this.property = leaseAgreement['property'];
  }
}
