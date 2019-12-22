import 'package:flutter/material.dart';

class CharacteristicDetailOutputWidget extends StatefulWidget {
  final characteristic;

  CharacteristicDetailOutputWidget(this.characteristic, {Key key}) : super(key: key);

  @override
  _CharacteristicDetailOutputWidgetState createState() => _CharacteristicDetailOutputWidgetState();
}

class _CharacteristicDetailOutputWidgetState extends State<CharacteristicDetailOutputWidget> {
  @override
  Widget build(BuildContext context) {
    print('CharacteristicDetailOutputWidget');
    return Center(child: Text('output', style: TextStyle(fontSize: 20)));
  }
}
