import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:weather_app/location/model.dart';
import 'package:weather_app/weather/model.dart';

class WeatherController extends GetxController {
  final _weather = Rx<Weather?>(null);
  final _loading = Rx<bool>(false);
  Location? _weatherLocation;

  Weather? get weather => _weather.value;

  bool get loading => _loading.value;

  // Sets the location to get weather data from
  getWeatherForLocation(Location location) {
    if (_weatherLocation == location) return;
    _weatherLocation = location;
    _getWeatherForLocation(location);
  }

  // Gets weather data from https://open-meteo.com
  _getWeatherForLocation(Location location) async {
    Dio dio = Dio();
    _loading.value = true;
    final response = await dio.get("https://api.open-meteo.com/v1/forecast?latitude=${location.latitude}&longitude=${location.longitude}&hourly=temperature_2m,precipitation_probability,precipitation&daily=sunrise,sunset&timezone=Europe%2FBerlin");
    if (kDebugMode) {
      print('WEATHER DATA: \n\n ${response.data}\n\n');
    }
    _weather.value = Weather.fromJson(response.data);
    _loading.value = false;
    if (kDebugMode) {
      print("++++ DONE LOADING DATA ++++");
    }
  }
}
