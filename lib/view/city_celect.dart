///
/// City settings screen
///
import 'package:flutter/material.dart';

import 'package:flutter_weather_exercise/util/utils.dart';

class CitySelection extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CitySelectionState();
  }

}

class _CitySelectionState extends State<CitySelection> {

  final TextEditingController _editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Utils.CITY),),
      body: Form(
        child: Row(
          children: <Widget>[
            Expanded(
              child: inputData(context),
            ),
            searchButton(context),
          ],
        ),
      ),
    );
  }

  // subroutine
  inputData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: TextFormField(
        controller: _editController,
        decoration: InputDecoration(
            labelText: Utils.CITY,
            hintText: Utils.HINT_TEXT,
        ),
      ),
    );
  }

  searchButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        Navigator.pop(context, _editController.text);
      },
    );
  }

}





