// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_by_day_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherByDayEntity _$WeatherByDayEntityFromJson(Map<String, dynamic> json) =>
    WeatherByDayEntity(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      timezone: json['timezone'] as String?,
      timezoneOffset: json['timezoneOffset'] as int?,
      current: json['current'] == null
          ? null
          : CurrentEntity.fromJson(json['current'] as Map<String, dynamic>),
      minutely: (json['minutely'] as List<dynamic>?)
          ?.map((e) => MinutelyEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      hourly: (json['hourly'] as List<dynamic>?)
          ?.map((e) => CurrentEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherByDayEntityToJson(WeatherByDayEntity instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'timezone': instance.timezone,
      'timezoneOffset': instance.timezoneOffset,
      'current': instance.current,
      'minutely': instance.minutely,
      'hourly': instance.hourly,
    };
