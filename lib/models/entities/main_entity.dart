import 'package:json_annotation/json_annotation.dart';

part 'main_entity.g.dart';

@JsonSerializable()
class MainEntity {
  MainEntity({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  @JsonKey()
  double? temp;
  @JsonKey()
  double? feelsLike;
  @JsonKey()
  double? tempMin;
  @JsonKey()
  double? tempMax;
  @JsonKey()
  double? pressure;
  @JsonKey()
  double? humidity;

  factory MainEntity.fromJson(Map<String, dynamic> json) => _$MainEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MainEntityToJson(this);
}
