import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Review/review_status.dart';
part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class Review {
  Review(this.reviewerId, this.revieweeId, this.score, this.description,
      this.status);

  // String id;
  String? reviewerId;
  String? revieweeId;
  int score;
  String? description;
  ReviewStatus status;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
