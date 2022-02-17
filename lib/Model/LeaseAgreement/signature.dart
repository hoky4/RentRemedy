import 'package:json_annotation/json_annotation.dart';
part 'signature.g.dart';

@JsonSerializable()
class Signature {
  Signature(this.signer, this.signDate);

  String signer;
  DateTime signDate;

  factory Signature.fromJson(Map<String, dynamic> json) => _$SignatureFromJson(json);

  Map<String, dynamic> toJson() => _$SignatureToJson(this);
}