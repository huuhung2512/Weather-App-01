String getWeatherIcon(String condition) {
  // Ánh xạ điều kiện thời tiết với tên tệp biểu tượng
  switch (condition.toLowerCase()) {
    case 'few clouds':
    case 'clear sky':
      return 'assets/icon_weather_home/sun.svg';
    case 'scattered clouds':
    case 'broken clouds':
    case 'overcast clouds':
      return 'assets/icon_weather_home/cloud.svg';
    case 'light rain':
    case 'shower rain':
    case 'rain':
    return 'assets/icon_weather_home/rain.svg';
    case 'thunderstorm':
      return 'assets/icon_weather_home/thunder.svg';
    case 'snow':
      return 'assets/icon_weather_home/snow.svg';
    case 'mist':
      return 'assets/icon_weather_home/wind.svg';
    default:
      return 'assets/icon_weather_home/sun.svg';
  }
}

String getWeatherIconHourly(String condition) {
  // Ánh xạ điều kiện thời tiết với tên tệp biểu tượng
   switch (condition.toLowerCase()) {
    case 'clear sky':
      return 'assets/icon_weather_hourly/sun_1.svg';
    case 'few clouds':
    case 'scattered clouds':
    case 'broken clouds':
    case 'overcast clouds':
      return 'assets/icon_weather_hourly/cloud_sun.svg';
    case 'light rain':
    case 'shower rain':
    case 'rain':
    return 'assets/icon_weather_hourly/rain_1.svg';
    case 'thunderstorm':
      return 'assets/icon_weather_home/thunder.svg';
    case 'snow':
      return 'assets/icon_weather_home/snow.svg';
    case 'mist':
      return 'assets/icon_weather_hourly/wind_1.svg';
    default:
      return 'assets/icon_weather_hourly/sun_1.svg';
  }
}