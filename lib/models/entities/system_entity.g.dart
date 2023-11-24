// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemEntity _$SystemEntityFromJson(Map<String, dynamic> json) => SystemEntity(
      type: json['type'] as int?,
      id: json['id'] as int?,
      country: json['country'] as String?,
      sunrise: (json['sunrise'] as num?)?.toDouble(),
      sunset: (json['sunset'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SystemEntityToJson(SystemEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
