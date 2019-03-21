///
/// Used to convert event to state
///
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_weather_exercise/controller/controller.dart';
import 'package:flutter_weather_exercise/model/model.dart';


// Weather event  start ===================================
// FechWeather, RefreshWeather
abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const[]]): super(props);
}

class FechWeather extends WeatherEvent {

  final String city;
  FechWeather({@required this.city}): assert(city != null), super([city]);

}

class RefreshWeather extends WeatherEvent {

  final String city;
  RefreshWeather({@required this.city}): assert(city != null), super([city]);

}
// Weather event end ======================================
// Weather state start ====================================
// WeatherEmpty, WeatherLoading, WeatherLoaded, WeatherError
abstract class WeatherState extends Equatable {
  WeatherState([List props = const[]]): super(props);
}

class WeatherEmpty extends WeatherState {

}

class WeatherLoading extends WeatherState {

}

class WeatherLoaded extends WeatherState {
    final Weather weather;
    WeatherLoaded({@required this.weather}): assert(weather != null), super([weather]);
}

class WeatherError extends WeatherState {

}
// Weather state end ======================================
// Weather bloc
// Used to convert event to state
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherController controller;

  WeatherBloc({@required this.controller}): assert(controller != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(
      WeatherState currentState,
      WeatherEvent event) async* {

      if (event is FechWeather) {
        yield WeatherLoading();
        try {
          final Weather weather = await controller.getWeather(event.city);
          yield WeatherLoaded(weather: weather);
        } catch(_) {
          yield WeatherError();
        }
      }

      if (event is RefreshWeather) {
        try {
          final Weather weather = await controller.getWeather(event.city);
          yield WeatherLoaded(weather: weather);
        } catch(_) {
          yield currentState;
        }
      }
  }

}