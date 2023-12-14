import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/common/app_color.dart';
import 'package:weather_app/common/app_icon.dart';
import 'package:weather_app/common/app_logic.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/entities/info_weather_entity.dart';
import 'package:weather_app/widgets/dayly_weather.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/splash_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherService weatherService = WeatherService(city: 'HaNoi');
  Future? currentWeatherData;
  Future? forecastWeatherData;
  bool isExpanded = false;
  bool isUserTyping = false;
  bool isLoading = true;

  void _toggleCard() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();
    loadWeatherData();
  }

  DateTime getNextDayDate() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    return tomorrow;
  }

  // Function to load both current and forecast weather data
  void loadWeatherData() {
    currentWeatherData = weatherService.getCurrentWeather();
    forecastWeatherData = weatherService.getWeatherForecast();
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
          icon: Icon(Icons.menu), // Thay đổi biểu tượng menu tùy chọn
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
                        onChanged: (value) {
                          isUserTyping = value.isNotEmpty;
                          weatherService.city = isUserTyping ? value : 'Hanoi';
                        },
                        onEditingComplete: () {
                          if (!isUserTyping) {
                            loadWeatherData();
                          }
                        },
                        decoration: InputDecoration(
                          hintText: weatherService.city,
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
              setState(() {
                loadWeatherData();
              });
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SplashScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19),
                        color: const Color(0xFFADA7FE),
                      ),
                      child: Text(
                        "Today",
                        style: TextStyle(
                          fontSize: 15,
                          color: const Color(0xFFF5D50FE),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: forecastWeatherData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: Container());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        Map<String, List<InfoWeatherEntity>> forecastData =
                            snapshot.data
                                as Map<String, List<InfoWeatherEntity>>;
                        final String day = forecastData.keys.elementAt(1);
                        final List<InfoWeatherEntity>? dailyForecast =
                            forecastData[day];
                        if (forecastData.isEmpty) {
                          return Center(
                              child: Text('No forecast data available.'));
                        }
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DailyWeatherScreen(
                                  day,
                                  dailyForecast!,
                                  weatherService.city,
                                  getColorAtIndex(1),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Tomorrow",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SplashScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Next Week",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: Future.wait([
                  currentWeatherData!,
                  forecastWeatherData!,
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    // Split the snapshot data into current and forecast data
                    InfoWeatherEntity infoWeatherEntity =
                        (snapshot.data as List)[0] as InfoWeatherEntity;
                    // ignore: unused_local_variable
                    Map<String, List<InfoWeatherEntity>> forecastData =
                        (snapshot.data as List)[1]
                            as Map<String, List<InfoWeatherEntity>>;

                    return Center(
                      child: ListTile(
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: GestureDetector(
                              onTap: _toggleCard,
                              child: Align(
                                alignment: Alignment.center,
                                child: isExpanded
                                    ? Stack(
                                        children: [
                                          Container(
                                            width: 374,
                                            height: 660.62,
                                            child: Card(
                                              elevation: 4,
                                              color: Color(0xFFF5D50FE),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(39.0),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Text(
                                                          "${roundTemperature(infoWeatherEntity.main?.temp)}°",
                                                          style: TextStyle(
                                                            fontSize: 120,
                                                            color: AppColors
                                                                .textPrimary,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: Text(
                                                        "${infoWeatherEntity.weather?[0].description ?? ''}",
                                                        style: TextStyle(
                                                          fontSize: 23,
                                                          color: AppColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: Text(
                                                        "Humidity",
                                                        style: TextStyle(
                                                          fontSize: 19,
                                                          color: AppColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Opacity(
                                                        opacity: 0.2,
                                                        child: Text(
                                                          "${roundTemperature(infoWeatherEntity.main?.humidity)}°",
                                                          style: TextStyle(
                                                            fontSize: 27,
                                                            color: AppColors
                                                                .textPrimary,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 50.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Center(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/chart1.png',
                                                                ),
                                                              ),
                                                              Center(
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/chart2.png',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // Padding(
                                                          //   padding:
                                                          //       EdgeInsets.all(
                                                          //            30),
                                                          //   child: Text(
                                                          //     'Rain Starting in 13 min',
                                                          //     style: TextStyle(
                                                          //       fontSize: 23,
                                                          //       color: AppColors
                                                          //           .textPrimary,
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                           Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                     30),
                                                            child: Text(
                                                              'Wind Speed: ${infoWeatherEntity.wind?.speed ?? ''} m/s ',
                                                              style: TextStyle(
                                                                fontSize: 23,
                                                                color: AppColors
                                                                    .textPrimary,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        5),
                                                            child: Text(
                                                              'Mặt trời mọc lúc: ${infoWeatherEntity.sunrise}',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .textPrimary,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        100),
                                                            child: Text(
                                                              'Mặt trời lặn lúc: ${infoWeatherEntity.sunset}',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: AppColors
                                                                    .textPrimary,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              left: 110,
                                              top: 530.0720214844,
                                              child: Container(
                                                width: 36.93,
                                                height: 36.93,
                                                child: Image.asset(
                                                  'assets/images/moon.png',
                                                  width: 36.93,
                                                  height: 36.93,
                                                ),
                                              )),
                                          Positioned(
                                            left: 0,
                                            top: 532.0720214844,
                                            child: Align(
                                              child: SizedBox(
                                                width: 191,
                                                height: 143.78,
                                                child: Image.asset(
                                                  'assets/images/cloud_design.png',
                                                  width: 191,
                                                  height: 143.78,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Stack(
                                        children: [
                                          Container(
                                            width: 374,
                                            height: 314,
                                            child: Card(
                                              elevation: 4,
                                              color: Color(0xFFF5D50FE),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(39.0),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Text(
                                                          ' ${roundTemperature(infoWeatherEntity.main?.temp)}°',
                                                          style: TextStyle(
                                                            fontSize: 120,
                                                            color: AppColors
                                                                .textPrimary,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: Text(
                                                        ' ${infoWeatherEntity.weather?[0].description ?? ''}',
                                                        style: TextStyle(
                                                          fontSize: 23,
                                                          color: AppColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      child: Text(
                                                        "Humidity",
                                                        style: TextStyle(
                                                          fontSize: 19,
                                                          color: AppColors
                                                              .textPrimary,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 20),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Opacity(
                                                          opacity: 0.2,
                                                          child: Text(
                                                            " ${roundTemperature(infoWeatherEntity.main?.humidity)}°",
                                                            style: TextStyle(
                                                              fontSize: 27,
                                                              color: AppColors
                                                                  .textPrimary,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              left: 237.8889160156,
                                              top: 212.24609375,
                                              child: Container(
                                                width: 77.73,
                                                height: 77.73,
                                                child: Image.asset(
                                                  'assets/images/moon.png',
                                                  width: 77.73,
                                                  height: 77.73,
                                                ),
                                              )),
                                          Positioned(
                                            // cloud26AgT (1:1857)
                                            left: 227.8889160156,
                                            top: 222.24609375,
                                            child: Align(
                                              child: SizedBox(
                                                width: 153.11,
                                                height: 113.17,
                                                child: Image.asset(
                                                  'assets/images/cloud_design.png',
                                                  width: 153.11,
                                                  height: 113.17,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Next 15 Days',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
              ),
              FutureBuilder(
                future: forecastWeatherData,
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
                    return SizedBox(
                      height: 193.46,
                      child: ListView.separated(
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
                          final description =
                              dailyForecast?[0].weather?[0].description;
                          if (dailyForecast == null || dailyForecast.isEmpty) {
                            return Container(); // Hoặc một widget khác tùy bạn chọn
                          }

                          Color selectedColor = getColorAtIndex(index);

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DailyWeatherScreen(
                                    day,
                                    dailyForecast,
                                    weatherService.city,
                                    selectedColor,
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  bottom: 0,
                                  child: Align(
                                    child: SizedBox(
                                      width: 70,
                                      height: 107.33,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          color: selectedColor,
                                        ),
                                        width: 145.21,
                                        height: 107.33,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 128,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(29),
                                    color: selectedColor,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      formattedDate,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textPrimary),
                                    ),
                                    SizedBox(height: 8),
                                    Align(
                                      child: SizedBox(
                                        child: SvgPicture.asset(
                                            getWeatherIcon(description!)),
                                      ),
                                    ),
                                    Text(
                                      '${roundTemperature(dailyForecast[0].main?.temp)}°',
                                      style: TextStyle(
                                          fontSize: 27,
                                          color: AppColors.textPrimary),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${roundTemperature(dailyForecast[0].main?.tempMin)}°',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.textPrimary
                                                  .withOpacity(0.5)),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '${roundTemperature(dailyForecast[0].main?.tempMax)}°',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors.textPrimary),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
