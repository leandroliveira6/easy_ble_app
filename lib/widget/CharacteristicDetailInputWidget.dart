import 'package:flutter/material.dart';

class CharacteristicDetailInputWidget extends StatefulWidget {
  final characteristic;

  CharacteristicDetailInputWidget(this.characteristic, {Key key}) : super(key: key);

  @override
  _CharacteristicDetailInputWidgetState createState() => _CharacteristicDetailInputWidgetState();
}

class _CharacteristicDetailInputWidgetState extends State<CharacteristicDetailInputWidget> {
  final _inputTextController =  TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    print('CharacteristicDetailInputWidget');
    return Row(
      children: <Widget>[
        Expanded(child: TextField(controller: _inputTextController)),
        Expanded(child: RaisedButton(child: Text('Enviar', style: TextStyle(fontSize: 16)), onPressed: (){},)),
      ],
    );
  }
}
