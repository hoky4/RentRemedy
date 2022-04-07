import 'package:json_annotation/json_annotation.dart';

enum FileType {
    @JsonValue(0)
    imagePNG,
    @JsonValue(1)
    imageJPEG,
}

enum ObjectType {
    @JsonValue(0)
    imageProperty,
    @JsonValue(1)
    imageMessage,
    @JsonValue(2)
    imageMaintenance,
}