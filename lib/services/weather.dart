import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/network.dart';
import 'package:clima_app/utilties/constants.dart';

class Weather {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHeper networkHeper = NetworkHeper(
        "$openWeatherMapUrl?units=metric&lat=${location.latitude}&lon=${location.longtitude}&appid=$apiKey");
    var weatherData = await networkHeper.getData();
    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHeper networkHeper = NetworkHeper(
        "$openWeatherMapUrl?q=$cityName&appid={$apiKey&units=metric");

    var weatherData = await networkHeper.getData();
    return weatherData;
  }
}
