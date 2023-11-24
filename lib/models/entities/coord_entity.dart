import 'package:json_annotation/json_annotation.dart';

part 'coord_entity.g.dart';

@JsonSerializable()
class CoordEntity {
  CoordEntity({
    this.lon,
    this.lat,
  });

  @JsonKey()
  double? lon;
  @JsonKey()
  double? lat;

  factory CoordEntity.fromJson(Map<String, dynamic> json) => _$CoordEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CoordEntityToJson(this);
}
