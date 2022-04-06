import 'package:json_annotation/json_annotation.dart';
import 'types.dart';

part 'upload_object_request.g.dart';

@JsonSerializable()
class UploadObjectRequest {
    final String filename;
    final ObjectType objectType;

    factory UploadObjectRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadObjectRequestFromJson(json);

    Map<String, dynamic> toJson() => _$UploadObjectRequestToJson(this);

    UploadObjectRequest(this.filename, this.objectType);
}