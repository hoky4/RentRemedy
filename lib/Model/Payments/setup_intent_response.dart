import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Payments/payment.dart';

part 'setup_intent_response.g.dart';

@JsonSerializable()
class SetupIntentResponse {
  SetupIntentResponse(this.status);

  String status;

  factory SetupIntentResponse.fromJson(Map<String, dynamic> json) =>
      _$SetupIntentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SetupIntentResponseToJson(this);
}
