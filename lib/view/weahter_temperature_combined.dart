///
///  Weather temperature combined widget
///
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weather_exercise/bloc/bloc.dart';
import 'package:flutter_weather_exercise/model/model.dart' as model;
import 'package:flutter_weather_exercise/view/view.dart';

class WeatherTemparatureCombined extends StatelessWidget {

  final model.Weather weather;

  WeatherTemparatureCombined({Key key, @required this.weather}):
      assert(weather != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: WeatherConditionWidget(condition: weather.condition),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocBuilder(
                    bloc: BlocProvider.of<SettingBloc>(context),
                    builder: (_, SettingState state) {
                      return WeatherTemperature(
                        temperature: weather.temp,
                        high: weather.maxTemp,
                        low: weather.minTemp,
                        units: state.units,
                      );
                    }
                ),
              )
          ],
        ),
        Center(
          child: Text(
            weather.formattedCondition,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w200,
              color: Colors.white
            ),
          ),
        ),
      ],
    );
  }

}


