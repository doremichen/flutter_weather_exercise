///
/// Weather setting screen
///
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weather_exercise/bloc/bloc.dart';

import 'package:flutter_weather_exercise/util/utils.dart';

class WeatherSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingBloc settingBloc = BlocProvider.of<SettingBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text(Utils.SETTING),),
      body: ListView(
        children: <Widget>[
          BlocBuilder(
              bloc: settingBloc,
              builder: (_, SettingState state) {
                return ListTile(
                    title: Text(Utils.TEMPUNIT),
                    isThreeLine: true,
                    subtitle: Text(Utils.SUBTEMTITLE),
                    trailing: Switch(
                        value: state.units == TemperatureUnits.celsius,
                        onChanged: (_) {
                          settingBloc.dispatch(TemperatureUnitsToggled());
                        }
                    ),
                );
              }
          )
        ],
      ),
    );
  }

}


