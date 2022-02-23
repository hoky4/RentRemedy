import 'package:json_annotation/json_annotation.dart';

part 'payment_intent_request.g.dart';

@JsonSerializable()
class PaymentIntentRequest {
  PaymentIntentRequest(this.paymentId, this.paymentMethodId);

  String paymentId;
  String paymentMethodId;

  factory PaymentIntentRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentIntentRequestToJson(this);
}
