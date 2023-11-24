import 'package:json_annotation/json_annotation.dart';

part 'wind_entity.g.dart';

@JsonSerializable()
class WindEntity {
  WindEntity({
    this.speed,
    this.deg,
    this.gust,
  });

  @JsonKey()
  double? speed;
  @JsonKey()
  double? deg;
  @JsonKey()
  double? gust;

  factory WindEntity.fromJson(Map<String, dynamic> json) => _$WindEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WindEntityToJson(this);
}
