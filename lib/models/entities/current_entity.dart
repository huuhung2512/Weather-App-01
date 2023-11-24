import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/models/entities/weather_entity.dart';

part 'current_entity.g.dart';

@JsonSerializable()
class CurrentEntity {
  CurrentEntity({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
  });

  @JsonKey()
  int? dt;
  @JsonKey()
  double? sunrise;
  @JsonKey()
  double? sunset;
  @JsonKey()
  double? temp;
  @JsonKey(name: 'feels_like')
  double? feelsLike;
  @JsonKey()
  double? pressure;
  @JsonKey()
  double? humidity;
  @JsonKey()
  double? dewPoint;
  @JsonKey()
  double? uvi;
  @JsonKey()
  double? clouds;
  @JsonKey()
  double? visibility;
  @JsonKey()
  double? windSpeed;
  @JsonKey()
  double? windDeg;
  @JsonKey()
  double? windGust;
  @JsonKey()
  List<WeatherEntity>? weather;
  @JsonKey()
  double? pop;

  factory CurrentEntity.fromJson(Map<String, dynamic> json) => _$CurrentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentEntityToJson(this);

  String get dateTime {
    return DateTime.fromMillisecondsSinceEpoch(dt! * 1000).toStringWith(DateTimeFormater.dateTimeHour);
  }

  String get hour {
    return DateTime.fromMillisecondsSinceEpoch(dt! * 1000).toStringWith(DateTimeFormater.dateTime);
  }
}

extension DateTimeExtension on DateTime {
  String toStringWith(String format) {
    String formattedDate = DateFormat(format).format(this);
    return formattedDate;
  }

  String customOnlyDate({String format = 'dd/MM/yyyy'}) {
    try {
      return toStringWith(format);
    } catch (_) {
      return '';
    }
  }
}

class DateTimeFormater {
  /// Dùng để hiển thị
  static String dateFormatVi = "dd/MM/yyyy";
  static String dateTimeFormatVi = "dd/MM/yyyy HH:mm:ss";
  static String dateTimeHour = "HH:mm dd/MM/yyyy";
  static String dateTime = "HH:mm";

  /// Format date from server và to server;
  static String dateTimeFormat = "yyyy-MM-dd";
  static String dateTimeFormatNormal = "yyyy-MM-dd HH:mm:ss";
  static String fullDateTimeFormat = "yyyy-MM-dd'T'hh:mm:ss.SSSZ";
  static String fullDateTimeKPI = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
}
