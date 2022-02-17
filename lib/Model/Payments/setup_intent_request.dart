import 'package:json_annotation/json_annotation.dart';
// import 'package:rentremedy_mobile/models/User/user.dart';

part 'setup_intent_request.g.dart';

@JsonSerializable(explicitToJson: true)
class SetupIntentRequest {
  SetupIntentRequest(
      // this.user,
      this.type,
      this.number,
      this.expMonth,
      this.expYear,
      this.cvc);

  // User user;
  String type;
  String number;
  int expMonth;
  int expYear;
  String cvc;

  factory SetupIntentRequest.fromJson(Map<String, dynamic> json) =>
      _$SetupIntentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SetupIntentRequestToJson(this);
}
