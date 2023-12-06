import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/models/entities/info_weather_entity.dart';

class WeatherService {
  String city;
  List<InfoWeatherEntity> infoWeatherEntities = [];
  InfoWeatherEntity? currentWeatherEntity;
  WeatherService({required this.city});

  Future<InfoWeatherEntity> getCurrentWeather() async {
    final String currentWeatherApiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=28acf82bec3ad3c08788ce3f7f2aa7da';
    final response = await http.get(Uri.parse(currentWeatherApiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return InfoWeatherEntity.fromJson(data);
    }

    throw Exception('Failed to load current weather');
  }

  Future<Map<String, List<InfoWeatherEntity>>> getWeatherForecast() async {
    final String apiUrl =
        'http://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=28acf82bec3ad3c08788ce3f7f2aa7da';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('list')) {
        List<Map<String, dynamic>> forecastData = List<Map<String, dynamic>>.from(data['list']);

        // Chuyển đổi dữ liệu dự báo sang đối tượng InfoWeatherEntity
        List<InfoWeatherEntity> forecastList = forecastData.map((forecast) {
          return InfoWeatherEntity.fromJson(forecast);
        }).toList();

        // Tạo một map để nhóm dữ liệu theo ngày
        Map<String, List<InfoWeatherEntity>> groupedData = {};
        for (var forecast in forecastList) {
          final timestamp = forecast.dt as int;
          final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
          final day = DateFormat('yyyy-MM-dd').format(date);

          if (!groupedData.containsKey(day)) {
            groupedData[day] = [];
          }

          groupedData[day]?.add(forecast);
        }

        return groupedData;
      }
    }

    return {};
  }

  
}
