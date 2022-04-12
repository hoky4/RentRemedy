import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Review/review_status.dart';
part 'review_request.g.dart';

@JsonSerializable(explicitToJson: true)
class ReviewRequest {
  ReviewRequest(this.id, this.reviewerId, this.revieweeId, this.score, this.description,
      this.status);

  String id;
  String reviewerId;
  String revieweeId;
  int score;
  String description;
  ReviewStatus status;

  factory ReviewRequest.fromJson(Map<String, dynamic> json) =>
      _$ReviewRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewRequestToJson(this);
}
