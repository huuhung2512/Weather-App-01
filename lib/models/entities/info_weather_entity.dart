import 'package:weather_app/models/entities/current_entity.dart';

import 'cloud_entity.dart';
import 'coord_entity.dart';
import 'main_entity.dart';
import 'system_entity.dart';
import 'weather_entity.dart';
import 'wind_entity.dart';

import 'package:json_annotation/json_annotation.dart';

part 'info_weather_entity.g.dart';

@JsonSerializable()
class InfoWeatherEntity {
  InfoWeatherEntity({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  @JsonKey()
  CoordEntity? coord;
  @JsonKey()
  List<WeatherEntity>? weather;
  @JsonKey()
  String? base;
  @JsonKey()
  MainEntity? main;
  @JsonKey()
  int? visibility;
  @JsonKey()
  WindEntity? wind;
  @JsonKey()
  CloudEntity? clouds;
  @JsonKey()
  int? dt;
  @JsonKey()
  SystemEntity? sys;
  @JsonKey()
  int? timezone;
  @JsonKey()
  int? id;
  @JsonKey()
  String? name;
  @JsonKey()
  int? cod;

  factory InfoWeatherEntity.fromJson(Map<String, dynamic> json) => _$InfoWeatherEntityFromJson(json);

  Map<String, dynamic> toJson(InfoWeatherEntity instance) => _$InfoWeatherEntityToJson(this);

  String get dateTime {
   try {
      DateTime dateTimeValue = DateTime.fromMillisecondsSinceEpoch(dt! * 1000, isUtc: true);
      DateTime vietnamDateTime = dateTimeValue.toLocal();
      return vietnamDateTime.customOnlyDate(format: DateTimeFormater.dateTimeHour);
    } catch (_) {
      return '';
    }
  }

  String get dateDay {
   try {
      DateTime dateTimeValue = DateTime.fromMillisecondsSinceEpoch(dt! * 1000, isUtc: true);
      DateTime vietnamDateTime = dateTimeValue.toLocal();
      return vietnamDateTime.customOnlyDate(format: DateTimeFormater.dateday);
    } catch (_) {
      return '';
    }
  }


    String get sunrise {
    try {
      int? timeSunrise  =  sys?.sunrise?.toInt(); 
      DateTime sunriseTime = DateTime.fromMillisecondsSinceEpoch((timeSunrise! * 1000) , isUtc: true);
      DateTime vietnamSunriseTime = sunriseTime.toLocal();
      return vietnamSunriseTime.customOnlyDate(format: DateTimeFormater.dateTime);
    } catch (_) {
      return '';
    }
  }

  String get sunset {
    try {
      int? timeSunset  =  sys?.sunset?.toInt(); 
      DateTime sunsetTime = DateTime.fromMillisecondsSinceEpoch((timeSunset! * 1000), isUtc: true);
      DateTime vietnamSunsetTime = sunsetTime.toLocal();
      return vietnamSunsetTime.customOnlyDate(format: DateTimeFormater.dateTime);
    } catch (_) {
      return '';
    }
  }
}



