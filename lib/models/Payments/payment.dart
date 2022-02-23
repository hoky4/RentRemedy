import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/models/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/models/User/user.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  Payment(
      this.id,
      // this.paymentIntentId,
      this.leaseAgreement,
      this.payer,
      this.chargeAmount,
      this.paidAmount,
      this.isLate,
      // this.lateFee,
      this.isLateFeeForgiven,
      this.isPaymentForgiven,
      this.dueDate,
      this.paymentDate);

  String id;
  // String paymentIntentId;
  LeaseAgreement leaseAgreement;
  User payer;
  int chargeAmount;
  int paidAmount;
  bool isLate;
  // int lateFee;
  bool? isLateFeeForgiven;
  bool? isPaymentForgiven;
  DateTime dueDate;
  DateTime? paymentDate;

  double get getDollarAmount => chargeAmount / 100;
  // double get getLateFeeDollarAmount => lateFee / 100;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
