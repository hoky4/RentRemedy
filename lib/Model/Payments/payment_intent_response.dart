import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Payments/payment.dart';

part 'payment_intent_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentIntentResponse {
  PaymentIntentResponse(this.payment, this.status);

  Payment payment;
  String status;

  factory PaymentIntentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentIntentResponseToJson(this);
}
