import 'package:json_annotation/json_annotation.dart';

part 'cloud_entity.g.dart';

@JsonSerializable()
class CloudEntity {
  CloudEntity({
    this.all,
  });

  @JsonKey()
  double? all;

  factory CloudEntity.fromJson(Map<String, dynamic> json) => _$CloudEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CloudEntityToJson(this);
}
