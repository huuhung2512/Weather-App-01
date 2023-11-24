import 'package:json_annotation/json_annotation.dart';

part 'minutely_entity.g.dart';

@JsonSerializable()
class MinutelyEntity {
  MinutelyEntity({
    this.dt,
    this.precipitation,
  });

  @JsonKey()
  int? dt;
  @JsonKey()
  double? precipitation;

  factory MinutelyEntity.fromJson(Map<String, dynamic> json) => _$MinutelyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MinutelyEntityToJson(this);
}
