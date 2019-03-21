///
/// Main screen
///

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weather_exercise/view/view.dart';
import 'package:flutter_weather_exercise/controller/controller.dart';
import 'package:flutter_weather_exercise/bloc/bloc.dart';

import 'package:flutter_weather_exercise/util/utils.dart';

class SimpleBlocDelegte extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }

}

void main() {
  final WeatherController _controller = WeatherController(
    apiClient: WeatherApiClient(
        httpClient: http.Client(),
    ),
  );

  BlocSupervisor().delegate = SimpleBlocDelegte();
  runApp(WeatherApp(weatherController: _controller));
}

// Weather app
class WeatherApp extends StatefulWidget {

  final WeatherController weatherController;

  WeatherApp({Key key, @required this.weatherController})
            : assert(weatherController != null), super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WeatherAppState();
  }

}

class _WeatherAppState extends State<WeatherApp> {

  final ThemeBloc _themeBloc = ThemeBloc();
  final SettingBloc _settingBloc = SettingBloc();


  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<ThemeBloc>(bloc: _themeBloc,),
        BlocProvider<SettingBloc>(bloc: _settingBloc,),
      ],
      child: BlocBuilder(
          bloc: _themeBloc,
          builder: (_, ThemeState state) {
            return MaterialApp(
              title: Utils.WEATHER_TITLE,
              theme: state.theme,
              home: WeatherScreen(
                weatherController: widget.weatherController,
              ),
            );
          }
      ),
    );
  }

  @override
  void dispose() {
    _themeBloc.dispose();
    _settingBloc.dispose();
    super.dispose();
  }

}