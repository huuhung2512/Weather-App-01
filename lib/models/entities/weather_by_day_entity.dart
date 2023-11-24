import 'package:json_annotation/json_annotation.dart';

import 'current_entity.dart';
import 'minutely_entity.dart';

part 'weather_by_day_entity.g.dart';

@JsonSerializable()
class WeatherByDayEntity {
  WeatherByDayEntity({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.minutely,
    this.hourly,
  });

  @JsonKey()
  double? lat;
  @JsonKey()
  double? lon;
  @JsonKey()
  String? timezone;
  @JsonKey()
  int? timezoneOffset;
  @JsonKey()
  CurrentEntity? current;
  @JsonKey()
  List<MinutelyEntity>? minutely;
  @JsonKey()
  List<CurrentEntity>? hourly;

  factory WeatherByDayEntity.fromJson(Map<String, dynamic> json) => _$WeatherByDayEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherByDayEntityToJson(this);
}
