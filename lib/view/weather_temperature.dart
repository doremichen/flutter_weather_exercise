///
/// Weather temperature widget
///
import 'package:flutter/material.dart';

import 'package:flutter_weather_exercise/bloc/bloc.dart';

class WeatherTemperature extends StatelessWidget {

  final double temperature;
  final double low;
  final double high;
  final TemperatureUnits units;

  WeatherTemperature({
      Key key,
      this.temperature,
      this.low,
      this.high,
      this.units
  }): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: _information('${_formattedTemperature(temperature)}°', 32.0, FontWeight.w600),
        ),
        Column(
          children: <Widget>[
            _information('${_formattedTemperature(high)}°', 16.0, FontWeight.w100),
            _information('${_formattedTemperature(low)}°', 16.0, FontWeight.w100),
          ],
        )
      ],
    );
  }

  // subroutine
  _information(String str, double size, FontWeight weight) {
    return Text(
      str,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: Colors.white,
      ),
    );
  }

  int _toFahrenheit(double celsius) => ((celsius * 9 / 5) + 32).round();

  int _formattedTemperature(double t) =>
      units == TemperatureUnits.fahrenheit ? _toFahrenheit(t) : t.round();

}


