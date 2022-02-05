import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment {
  Payment(
      this.id,
      // this.paymentIntentId,
      this.leaseAgreement,
      // this.user,
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
  String leaseAgreement;
  // String user;
  int chargeAmount;
  int paidAmount;
  bool isLate;
  // int lateFee;
  bool? isLateFeeForgiven;
  bool? isPaymentForgiven;
  DateTime dueDate;
  DateTime? paymentDate;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
