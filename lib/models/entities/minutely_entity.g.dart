// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minutely_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinutelyEntity _$MinutelyEntityFromJson(Map<String, dynamic> json) =>
    MinutelyEntity(
      dt: json['dt'] as int?,
      precipitation: (json['precipitation'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MinutelyEntityToJson(MinutelyEntity instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'precipitation': instance.precipitation,
    };
