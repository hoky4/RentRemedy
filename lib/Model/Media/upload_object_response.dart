import 'package:json_annotation/json_annotation.dart';
import 'bucket_object.dart';
part 'upload_object_response.g.dart';

@JsonSerializable()
class UploadObjectResponse {
    final BucketObject bucketObject;
    final String putUrl;

    factory UploadObjectResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadObjectResponseFromJson(json);

    Map<String, dynamic> toJson() => _$UploadObjectResponseToJson(this);

    UploadObjectResponse(this.bucketObject, this.putUrl);
}