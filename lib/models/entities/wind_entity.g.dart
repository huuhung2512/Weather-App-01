// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wind_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WindEntity _$WindEntityFromJson(Map<String, dynamic> json) => WindEntity(
      speed: (json['speed'] as num?)?.toDouble(),
      deg: (json['deg'] as num?)?.toDouble(),
      gust: (json['gust'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WindEntityToJson(WindEntity instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };
