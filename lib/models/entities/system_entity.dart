import 'package:json_annotation/json_annotation.dart';

part 'system_entity.g.dart';

@JsonSerializable()
class SystemEntity {
  SystemEntity({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  @JsonKey()
  int? type;
  @JsonKey()
  int? id;
  @JsonKey()
  String? country;
  @JsonKey()
  double? sunrise;
  @JsonKey()
  double? sunset;

  factory SystemEntity.fromJson(Map<String, dynamic> json) => _$SystemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SystemEntityToJson(this);
}
