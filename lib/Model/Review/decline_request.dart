import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Review/review_status.dart';
part 'decline_request.g.dart';

@JsonSerializable(explicitToJson: true)
class DeclineRequest {
  DeclineRequest(this.leaseAgreementId, this.status);

  String leaseAgreementId;
  ReviewStatus status;

  factory DeclineRequest.fromJson(Map<String, dynamic> json) =>
      _$DeclineRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeclineRequestToJson(this);
}
