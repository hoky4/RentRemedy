import 'package:json_annotation/json_annotation.dart';
import 'package:rentremedy_mobile/Model/Media/types.dart';
part 'bucket_object.g.dart';

@JsonSerializable(explicitToJson: true)
class BucketObject {
  final String id;
  final String createdBy;
  final String originalFileName;
  final String newFileName;
  final FileType fileType;
  final String getUrl;

  factory BucketObject.fromJson(Map<String, dynamic> json) =>
      _$BucketObjectFromJson(json);

  Map<String, dynamic> toJson() => _$BucketObjectToJson(this);

  BucketObject(this.id, this.createdBy, this.originalFileName, this.newFileName, this.fileType, this.getUrl);
}