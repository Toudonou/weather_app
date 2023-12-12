class Weather {
  double? temp;
  double? tempMax;
  double? tempMin;
  double? feelsLike;
  double? precipProb;
  double? windSpeed;
  double? windDir;
  double? humidity;
  String? condition;
  String? sunrise;
  String? sunset;
  String? icon;
  String? datetime;

  Weather.perDefault();

  Weather(
    this.temp,
    this.tempMax,
    this.tempMin,
    this.feelsLike,
    this.precipProb,
    this.windSpeed,
    this.windDir,
    this.humidity,
    this.condition,
    this.sunrise,
    this.sunset,
    this.icon,
  );

  Weather.fromCurrent(Map<String, dynamic> data, int hour) {
    tempMax = data["days"][0]["tempmax"] as double?;
    tempMin = data["days"][0]["tempmin"] as double?;
    sunrise = data["days"][0]["sunrise"] as String?;
    sunset = data["days"][0]["sunset"] as String?;

    feelsLike = data["days"][0]["hours"][hour]["feelslike"] as double?;
    precipProb = data["days"][0]["hours"][hour]["precipprob"] as double?;
    windSpeed = data["days"][0]["hours"][hour]["windspeed"] as double?;
    windDir = data["days"][0]["hours"][hour]["winddir"] as double?;
    humidity = data["days"][0]["hours"][hour]["humidity"] as double?;
    condition = data["days"][0]["hours"][hour]["conditions"] as String?;
    temp = data["days"][0]["hours"][hour]["temp"] as double?;
    icon = data["days"][0]["hours"][hour]["icon"] as String?;
    datetime = data["days"][0]["hours"][hour]["datetime"] as String?;
  }

  List<Weather> hoursForecastWeather(Map<String, dynamic> data, int hour) {
    List<Weather> weatherList = [];
    for (int day = 0, cmp = 1; cmp <= 24; cmp++) {
      Weather weather = Weather.perDefault();
      weather.temp = data["days"][day]["hours"][hour]["temp"] as double?;
      weather.icon = data["days"][day]["hours"][hour]["icon"] as String?;
      weather.datetime = data["days"][0]["hours"][hour]["datetime"] as String?;
      weatherList.add(weather);
      if (hour == 23) {
        day++;
        hour = 0;
      } else {
        hour++;
      }
    }
    return weatherList;
  }

  List<Weather> daysForecastWeather(Map<String, dynamic> data) {
    List<Weather> weatherList = [];
    for (int day = 0; day <= 9; day++) {
      Weather weather = Weather.perDefault();
      weather.tempMax = data["days"][day]["tempmax"] as double?;
      weather.tempMin = data["days"][day]["tempmin"] as double?;
      weather.condition = data["days"][day]["conditions"] as String?;
      weather.icon = data["days"][day]["icon"] as String?;
      weatherList.add(weather);
    }
    return weatherList;
  }
}
