import 'package:flutter/material.dart';
import 'package:weather_app/test_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isExpanded = false;

  void _toggleCard() {
    setState(() {
      isExpanded = !isExpanded;
    });
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
                        decoration: InputDecoration(
                          hintText: "India, Mumbai",
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
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
                  Container(
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
                          builder: (context) =>  TestWeatherScreen(),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: _toggleCard,
                    child: Align(
                      alignment: Alignment.center,
                      child: isExpanded ? ExpandedCard() : CollapsedCard(),
                    ),
                  ),
                ),
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
              SizedBox(
                height: 176,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: weathers.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 16);
                  },
                  itemBuilder: (context, index) {
                    final item = weathers[index];
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 128,
                          height: 176,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            color: item.color,
                          ),
                        ),
                      ],
                    );
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

class CollapsedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Color(0xFFF5D50FE),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(39.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "25°",
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
                "Clouds & sun",
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
              padding: const EdgeInsets.only(bottom: 40),
              child: Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: 0.2,
                  child: Text(
                    "35°",
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
    );
  }
}

class ExpandedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Color(0xFFF5D50FE),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(39.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "25°",
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
                "Clouds & sun",
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
                  "35°",
                  style: TextStyle(
                    fontSize: 27,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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
                    padding: EdgeInsets.only(top: 70),
                    child: Text(
                      'Rain Starting in 13 min',
                      style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 100),
                    child: Text(
                      'Nearest precip: 6 mi to the west',
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
    );
  }
}

class Weather {
  String? date;
  String? iconWeather;
  String? avgTemp;
  String? minTemp;
  String? maxTemp;
  Color color;
  Weather({
    this.date,
    this.iconWeather,
    this.avgTemp,
    this.minTemp,
    this.maxTemp,
    required this.color,
  });
}

List<Weather> weathers = [
  Weather(
    date: 'Monday',
    iconWeather: 'icon',
    avgTemp: '40',
    minTemp: '56',
    maxTemp: '69',
    color: Colors.red,
  ),
  Weather(
    date: 'Tuesday',
    iconWeather: 'icon',
    avgTemp: '42',
    minTemp: '58',
    maxTemp: '71',
    color: Colors.blue,
  ),
  Weather(
    date: 'Wednesday',
    iconWeather: 'icon',
    avgTemp: '45',
    minTemp: '59',
    maxTemp: '73',
    color: Colors.green,
  ),
  Weather(
    date: 'Thursday',
    iconWeather: 'icon',
    avgTemp: '41',
    minTemp: '57',
    maxTemp: '70',
    color: Colors.orange,
  ),
  Weather(
    date: 'Friday',
    iconWeather: 'icon',
    avgTemp: '39',
    minTemp: '55',
    maxTemp: '68',
    color: Colors.purple,
  ),
  Weather(
    date: 'Saturday',
    iconWeather: 'icon',
    avgTemp: '43',
    minTemp: '60',
    maxTemp: '75',
    color: Colors.cyan,
  ),
  Weather(
    date: 'Sunday',
    iconWeather: 'icon',
    avgTemp: '38',
    minTemp: '54',
    maxTemp: '67',
    color: Colors.pink,
  ),
];
