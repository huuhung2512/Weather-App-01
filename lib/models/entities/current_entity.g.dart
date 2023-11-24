// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentEntity _$CurrentEntityFromJson(Map<String, dynamic> json) =>
    CurrentEntity(
      dt: json['dt'] as int?,
      sunrise: (json['sunrise'] as num?)?.toDouble(),
      sunset: (json['sunset'] as num?)?.toDouble(),
      temp: (json['temp'] as num?)?.toDouble(),
      feelsLike: (json['feels_like'] as num?)?.toDouble(),
      pressure: (json['pressure'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
      dewPoint: (json['dewPoint'] as num?)?.toDouble(),
      uvi: (json['uvi'] as num?)?.toDouble(),
      clouds: (json['clouds'] as num?)?.toDouble(),
      visibility: (json['visibility'] as num?)?.toDouble(),
      windSpeed: (json['windSpeed'] as num?)?.toDouble(),
      windDeg: (json['windDeg'] as num?)?.toDouble(),
      windGust: (json['windGust'] as num?)?.toDouble(),
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => WeatherEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      pop: (json['pop'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CurrentEntityToJson(CurrentEntity instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'dewPoint': instance.dewPoint,
      'uvi': instance.uvi,
      'clouds': instance.clouds,
      'visibility': instance.visibility,
      'windSpeed': instance.windSpeed,
      'windDeg': instance.windDeg,
      'windGust': instance.windGust,
      'weather': instance.weather,
      'pop': instance.pop,
    };
