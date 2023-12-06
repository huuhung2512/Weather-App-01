import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/entities/info_weather_entity.dart';
import 'package:weather_app/services/weather_service.dart';
import 'dart:math';

import 'package:weather_app/widgets/dayly_weather.dart';

class WeatherForecastWidget extends StatefulWidget {
  @override
  _WeatherForecastWidgetState createState() => _WeatherForecastWidgetState();
}

class _WeatherForecastWidgetState extends State<WeatherForecastWidget> {
  final WeatherService weatherService = WeatherService(city: 'Hanoi');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: Column(
        children: [
          // Thêm ô hiển thị thời tiết hiện tại
          FutureBuilder(
            future: weatherService.getCurrentWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                InfoWeatherEntity currentWeather =
                    snapshot.data as InfoWeatherEntity;
                final temperature = currentWeather.main?.temp;
                final description = currentWeather.weather?[0].description;

                return Card(
                  child: ListTile(
                    title: Text('Current Weather'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Temperature: ${temperature?.toStringAsFixed(1)}°C'),
                        Text('Description: $description'),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          // Hiển thị dự báo thời tiết
          Expanded(
            child: FutureBuilder(
              future: weatherService.getWeatherForecast(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  Map<String, List<InfoWeatherEntity>> forecastData =
                      snapshot.data as Map<String, List<InfoWeatherEntity>>;

                  if (forecastData.isEmpty) {
                    return Center(child: Text('No forecast data available.'));
                  }

                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 16);
                    },
                    itemCount: forecastData.length,
                    itemBuilder: (context, index) {
                      final String day = forecastData.keys.elementAt(index);
                      final String formattedDate =
                          DateFormat('EEEE').format(DateTime.parse(day));
                      final List<InfoWeatherEntity>? dailyForecast =
                          forecastData[day];

                      if (dailyForecast == null || dailyForecast.isEmpty) {
                        return Container(); // Hoặc một widget khác tùy bạn chọn
                      }

                      final Color randomColor =
                          Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                              .withOpacity(1.0);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DailyWeatherScreen(day, dailyForecast),
                            ),
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 128,
                              height: 176,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(29),
                                color: randomColor,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8),
                                Icon(
                                  // Thêm biểu tượng thời tiết vào đây
                                  Icons.cloud,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                Text(
                                  '${dailyForecast[0].main?.temp?.toStringAsFixed(1) ?? 'N/A'}°C',
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${dailyForecast[0].main?.tempMax?.toStringAsFixed(1) ?? 'N/A'}°C',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '${dailyForecast[0].main?.tempMin?.toStringAsFixed(1) ?? 'N/A'}°C',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
