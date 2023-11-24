// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coord_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordEntity _$CoordEntityFromJson(Map<String, dynamic> json) => CoordEntity(
      lon: (json['lon'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CoordEntityToJson(CoordEntity instance) =>
    <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };
