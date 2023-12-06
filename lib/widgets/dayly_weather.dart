import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/entities/info_weather_entity.dart';

class DailyWeatherScreen extends StatelessWidget {
  final String day;
  final List<InfoWeatherEntity> dailyForecast;

  DailyWeatherScreen(this.day, this.dailyForecast);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather on $day'),
      ),
      body: ListView.builder(
        itemCount: dailyForecast.length,
        itemBuilder: (context, index) {
          final timestamp = dailyForecast[index].dt as int;
          final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
          final time = DateFormat('h:mm a').format(date);
          final temperature = dailyForecast[index].main?.temp;
          final description = dailyForecast[index].weather?[0].description;

          return ListTile(
            title: Text('$time: ${temperature?.toStringAsFixed(1)}°C'),
            subtitle: Text(description ?? ''),
          );
        },
      ),
    );
  }
}
