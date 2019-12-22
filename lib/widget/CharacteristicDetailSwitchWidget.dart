import 'package:flutter/material.dart';

class CharacteristicDetailSwitchWidget extends StatefulWidget {
  final characteristic;

  CharacteristicDetailSwitchWidget(this.characteristic, {Key key}) : super(key: key);

  @override
  _CharacteristicDetailSwitchWidgetState createState() => _CharacteristicDetailSwitchWidgetState();
}

class _CharacteristicDetailSwitchWidgetState extends State<CharacteristicDetailSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    print('CharacteristicDetailSwitchWidget');
    return Row(
      children: <Widget>[
        Expanded(child: RaisedButton(child: Text('Ligar', style: TextStyle(fontSize: 16)), onPressed: (){},)),
        Expanded(child: RaisedButton(child: Text('Desligar', style: TextStyle(fontSize: 16)), onPressed: (){},)),
      ],
    );
  }
}