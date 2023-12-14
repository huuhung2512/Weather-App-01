import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/common/app_color.dart';
import 'package:weather_app/common/app_icon.dart';
import 'package:weather_app/common/app_logic.dart';
import 'package:weather_app/models/entities/info_weather_entity.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:flutter_svg/svg.dart';

class DailyWeatherScreen extends StatelessWidget {
  final String day;
  final List<InfoWeatherEntity> dailyForecast;
  final String city;
  final Color selectedColor;
  DailyWeatherScreen(
    this.day,
    this.dailyForecast,
    this.city,
    this.selectedColor,
  );

  final WeatherService weatherService = WeatherService(city: 'HaNoi');

  void loadWeatherData() {
    weatherService.city = city;
    weatherService.getWeatherForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(left: 57),
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        onChanged: (value) {},
                        onEditingComplete: () {
                          loadWeatherData();
                        },
                        decoration: InputDecoration(
                          hintText: city,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              loadWeatherData();
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 700.08,
                child: FutureBuilder(
                  future: weatherService.getCurrentWeather(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final String formattedDate =DateFormat('EEEE').format(DateTime.parse(day));
                      final description1 =dailyForecast[0].weather?[0].description;
                      return Stack(
                        children: [
                          Card(
                            margin: EdgeInsets.only(top: 25),
                            color: selectedColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(39.0),
                            ),
                            child: ListTile(
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    formattedDate,
                                    style: TextStyle(
                                        fontSize: 47,
                                        color: AppColors.textPrimary),
                                  ),
                                  SizedBox(height: 18),
                                  Align(
                                    child: SizedBox(
                                      width: 159.75,
                                      height: 159.75,
                                      child: SvgPicture.asset(
                                          getWeatherIcon(description1!)),
                                    ),
                                  ),
                                  Text(
                                    '${roundTemperature(dailyForecast[0].main?.temp)}°',
                                    style: TextStyle(
                                        fontSize: 61,
                                        color: AppColors.textPrimary),
                                  ),
                                  SizedBox(height: 18),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${roundTemperature(dailyForecast[0].main?.tempMin )}°',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: AppColors.textPrimary
                                                .withOpacity(0.5)),
                                      ),
                                      SizedBox(width: 18),
                                      Text(
                                        '${roundTemperature(dailyForecast[0].main?.tempMax )}°',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: AppColors.textPrimary),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 50),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(39.0),
                                    ),
                                    color: Colors.white,
                                    child: SizedBox(
                                      height: 147,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                          dailyForecast.length,
                                          (index) {
                                            final timestamp = dailyForecast[index].dt as int;
                                            final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
                                            final time = DateFormat('HH:mm').format(date);
                                            final temperature =dailyForecast[index].main?.temp;
                                            final description =dailyForecast[index].weather?[0].description;
                                            return Container(
                                              width:59, // Điều chỉnh chiều rộng của mỗi phần tử
                                              height:81.5, // Điều chỉnh chiều cao của mỗi phần tử
                                              margin: EdgeInsets.symmetric(horizontal:10), // Tạo khoảng cách giữa các phần tử
                                              padding: EdgeInsets.all(8),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center, // Căn chỉnh phần tử con theo chiều dọc
                                                children: [
                                                  Text(
                                                    time,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Align(
                                                    child: SizedBox(
                                                      child: SvgPicture.asset(getWeatherIconHourly(description!)),
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Text(
                                                    '${temperature?.round()}°',
                                                    style:
                                                        TextStyle(fontSize: 19),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 181,
                            top: 0,
                            child: Align(
                              child: SizedBox(
                                width: 52,
                                height: 52,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(26),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0x29000000),
                                          offset: Offset(0, 3),
                                          blurRadius: 12.5,
                                        ),
                                      ],
                                    ),
                                    child: Align(
                                      child: SizedBox(
                                        width: 10.38,
                                        height: 10.75,
                                        child: SvgPicture.asset(
                                            'assets/vectors/ic_exit.svg'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
