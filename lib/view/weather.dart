///
/// Weather screen
///
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weather_exercise/view/view.dart';
import 'package:flutter_weather_exercise/controller/controller.dart';
import 'package:flutter_weather_exercise/bloc/bloc.dart';

import 'package:flutter_weather_exercise/util/utils.dart';

class WeatherScreen extends StatefulWidget {

  final WeatherController weatherController;

  WeatherScreen({
    Key key,
    this.weatherController
  }): assert(weatherController != null), super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WeatherScreenState();
  }

}

class _WeatherScreenState extends State<WeatherScreen> {

  WeatherBloc _weatherBloc;
  Completer<void> _refreshCompleter;
  WeatherLoaded _loadedState;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.WEATHER_TITLE),
        actions: <Widget>[
          _actionButton(Icons.settings, _navigetToSetting),
          _actionButton(Icons.search, _navigetToCitySelection),
        ],
      ),
      body: Center(
        child: BlocBuilder(
          bloc: _weatherBloc,
          builder: (_, WeatherState state) {
            if (state is WeatherEmpty) {
              return Center(child: Text('Please Select a Location'));
            }
            if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is WeatherLoaded) {
              final weather = state.weather;
              final themeBloc = BlocProvider.of<ThemeBloc>(context);
              themeBloc.dispatch(WeatherChanged(condition: weather.condition));

              _refreshCompleter?.complete();
              _refreshCompleter = Completer();

              return BlocBuilder(
                bloc: themeBloc,
                builder: (_, ThemeState themeState) {
                  return GradientContainer(
                    color: themeState.color,
                    child: RefreshIndicator(
                      onRefresh: () {
                        _weatherBloc.dispatch(
                          RefreshWeather(city: state.weather.location),
                        );
                        return _refreshCompleter.future;
                      },
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 100.0),
                            child: Center(
                              child: WeatherLocation(location: weather.location),
                            ),
                          ),
                          Center(
                            child: WeatherLastUpdated(dateTime: weather.lastUpdated),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.0),
                            child: Center(
                              child: WeatherTemparatureCombined(
                                weather: weather,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is WeatherError) {
              return Text(
                'Something went wrong!',
                style: TextStyle(color: Colors.red),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    _weatherBloc = WeatherBloc(controller: widget.weatherController);
  }

  @override
  void dispose() {
    _weatherBloc.dispose();
    super.dispose();
  }

  //
  //subroutine
  //
  // build action button
  _actionButton(IconData icon, VoidCallback callBack) {
    return IconButton(
        icon: Icon(icon),
        onPressed: callBack,
    );
  }

  _navigetToSetting() {
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => WeatherSetting(),
        )
    );
  }

  _navigetToCitySelection() async {
    final city = await Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => CitySelection(),
        )
    );

    if (city != null) {
      _weatherBloc.dispatch(FechWeather(city: city));
    }
  }
}
