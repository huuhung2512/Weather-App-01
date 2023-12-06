  String roundTemperature(double? temp) {
    if (temp != null) {
      return temp.round().toString();
    } else {
      return '';
    }
  }