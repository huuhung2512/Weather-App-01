import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weather_app/common/app_logic.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/entities/info_weather_entity.dart';
import 'package:weather_app/widgets/dayly_weather.dart';
import 'package:weather_app/widgets/nexweek.dart';
import 'package:intl/intl.dart';

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
        toolbarHeight: 120,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
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
                          // Kiểm tra nếu không phải đang nhập, mới load dữ liệu
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
                  // Khi người dùng nhấn vào icon find, bạn sẽ load dữ liệu
                  loadWeatherData();
                });
              },
              icon: const Icon(Icons.search))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
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
                          builder: (context) => WeatherForecastWidget(),
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
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Tomorrow",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherForecastWidget(),
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
                                    ? Card(
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
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Text(
                                                    "${roundTemperature(infoWeatherEntity.main?.temp)}°",
                                                    style: TextStyle(
                                                      fontSize: 120,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                  "${infoWeatherEntity.weather?[0].description ?? ''}",
                                                  style: TextStyle(
                                                    fontSize: 23,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                  "Humidity",
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Opacity(
                                                  opacity: 0.2,
                                                  child: Text(
                                                    "${roundTemperature(infoWeatherEntity.main?.humidity) ?? ''}°",
                                                    style: TextStyle(
                                                      fontSize: 27,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Center(
                                                          child: Image.asset(
                                                            'assets/images/chart1.png',
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Image.asset(
                                                            'assets/images/chart2.png',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 70),
                                                      child: Text(
                                                        'Rain Starting in 13 min',
                                                        style: TextStyle(
                                                          fontSize: 23,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 100),
                                                      child: Text(
                                                        'Nearest precip: ${infoWeatherEntity.wind?.speed ?? ''}',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Card(
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
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Text(
                                                    ' ${roundTemperature(infoWeatherEntity.main?.temp)}°',
                                                    style: TextStyle(
                                                      fontSize: 120,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                  ' ${infoWeatherEntity.weather?[0].description ?? ''}',
                                                  style: TextStyle(
                                                    fontSize: 23,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                  "Humidity",
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 40),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Opacity(
                                                    opacity: 0.2,
                                                    child: Text(
                                                      " ${roundTemperature(infoWeatherEntity.main?.humidity) ?? ''}°",
                                                      style: TextStyle(
                                                        fontSize: 27,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                            ],
                                          ),
                                        ),
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
                      height: 176,
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

                          if (dailyForecast == null || dailyForecast.isEmpty) {
                            return Container(); // Hoặc một widget khác tùy bạn chọn
                          }

                          final Color randomColor = Color(
                                  (Random().nextDouble() * 0xFFFFFF).toInt() <<
                                      0)
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
                                      '${(dailyForecast[0].main?.temp ?? 0.0).round()}°C',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${(dailyForecast[0].main?.tempMax ?? 0.0).round()}°C',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '${(dailyForecast[0].main?.tempMin ?? 0.0).round()}°C',
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
