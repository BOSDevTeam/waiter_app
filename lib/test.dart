
import 'package:flutter/material.dart';

class FavoriteCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteCityState();
  }
}

class _FavoriteCityState extends State<FavoriteCity> {
  String nameCity = '';
  String _loveLevel = '';
  bool _selected = false;
  var _howMuchLoved = ['A little', 'So so', 'Quite a bit', 'A lot', 'Greatly'];

  @override
  Widget build(BuildContext context) {
    print('Widget Built');
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite city app'),
        elevation: 8.0,
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              onSubmitted: (String userInput) {
                setState(() {
                  print('State rebuilt');
                  nameCity = userInput;
                });
              },
            ),
            DropdownButton<String>(
              hint: Text('How much do you love the city?'),
              items: _howMuchLoved.map((String myMenuItem) {
                return DropdownMenuItem<String>(
                  value: myMenuItem,
                  child: Text(myMenuItem),
                );
              }).toList(),
              onChanged: (value) {
                _dropDownItemSelected(value!);
              },
              /* onChanged: (String valueSelectedByUser) {
                _dropDownItemSelected(valueSelectedByUser);
              }, */
              value: _selected ? _loveLevel : null,
              isDense: true,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Your favorite city is $nameCity ! \n ... and you love it $_loveLevel',
                style: TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _dropDownItemSelected(String valueSelectedByUser) {
    setState(() {
      this._loveLevel = valueSelectedByUser;
      _selected = true;
    });
  }
}