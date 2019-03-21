///
/// Data provider
///
import 'dart:convert';
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_weather_exercise/model/model.dart';

//
// Used to response the weather data via http request
//
class WeatherApiClient {

  static const baseUrl = 'https://www.metaweather.com';

  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient}): assert(httpClient != null);

  // Public interface
  Future<int> getLocationId(String city) async {
    print('[getLocationId] enter');
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locatoionResponse = await this.httpClient.get(locationUrl);

    // Valid check
    if (locatoionResponse.statusCode != 200) {
      print('[getLocationId] locatoionResponse.statusCode != 200');
      throw Exception('Error: getLocationId for $city');
    }

    final locationJson = jsonDecode(locatoionResponse.body) as List;
    print('[getLocationId] exit $locationJson');
    return (locationJson.first)['woeid'];
  }

  Future<Weather> fetchWeather(int id) async {
    print('[fetchWeather] enter');
    final weatherUrl = '$baseUrl/api/location/$id';
    final weatherResponse = await this.httpClient.get(weatherUrl);

    // Valid check
    if (weatherResponse.statusCode != 200) {
      print('[fetchWeather] weatherResponse.statusCode != 200');
      throw Exception('Error: fetchWeather for $id');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    print('[fetchWeather] exit $weatherJson');
    return Weather.fromJson(weatherJson);


  }
}


