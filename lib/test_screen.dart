import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:weather_app/models/entities/info_weather_entity.dart';


class TestWeatherScreen extends StatefulWidget {
  const TestWeatherScreen({Key? key}) : super(key: key);

  @override
  _TestWeatherScreenState createState() => _TestWeatherScreenState();
}

class _TestWeatherScreenState extends State<TestWeatherScreen> {
  InfoWeatherEntity? infoWeatherEntity;

  @override
  void initState() {
    super.initState();
    getDataWeather();
  }

  void getDataWeather() async {
    try {
      var url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=HaNoi&units=metric&appid=82d78aef7a2755507e23056a5b7b885f');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        infoWeatherEntity = InfoWeatherEntity.fromJson(jsonResponse);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ' ${infoWeatherEntity?.name ?? ''}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              ' ${infoWeatherEntity?.main?.temp.toString() ?? ''}°C',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              ' ${infoWeatherEntity?.dateTime ?? ''}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              ' ${infoWeatherEntity?.weather?[0].description ?? ''}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Max :  ${infoWeatherEntity?.main?.tempMax ?? ''}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Min :  ${infoWeatherEntity?.main?.tempMin ?? ''}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Humidity :  ${infoWeatherEntity?.main?.humidity ?? ''}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
