///
/// Weather location widget
///
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

class WeatherLocation extends StatelessWidget {

  final String location;

  WeatherLocation({Key key, @required this.location})
            :assert(location != null), super(key: key);

  @override
  Widget build(BuildContext context) {

    return Text(
      location,
      style: TextStyle(
        fontSize:  30.0,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
    );
  }

}

