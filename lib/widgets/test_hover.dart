import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';

class Appbar2 extends StatefulWidget {
  const Appbar2({super.key});

  @override
  State<Appbar2> createState() => _Appbar2State();
}

class _Appbar2State extends State<Appbar2> {
  WeatherService weatherService = WeatherService(city: 'HaNoi');
  Future? currentWeatherData;
  Future? forecastWeatherData;
  bool isExpanded = false;
  bool isUserTyping = false;
  bool isLoading = true;
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
        leading: IconButton(
          icon: Icon(Icons.menu), // Thay đổi biểu tượng menu tùy chọn
          onPressed: () {
            // Xử lý sự kiện khi nút menu được nhấn
            // Điều này có thể bao gồm hiển thị drawer hoặc thực hiện hành động cụ thể khác
          },
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
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
