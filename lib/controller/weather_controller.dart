///
/// Weather controller
///

import 'package:flutter_weather_exercise/model/model.dart';
import 'package:flutter_weather_exercise/controller/weather_api_client.dart';

// Used to provider the interface for bloc module
class WeatherController {
  final WeatherApiClient apiClient;

  WeatherController({this.apiClient}): assert(apiClient != null);

  // public interface
  Future<Weather> getWeather(String city) async {
    // get location id
    final locationId = await apiClient.getLocationId(city);
    // get weather by location id
    return await apiClient.fetchWeather(locationId);
  }
}