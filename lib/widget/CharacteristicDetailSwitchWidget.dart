import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/DeviceBloc.dart';
import 'package:flutter/material.dart';

class CharacteristicDetailSwitchWidget extends StatelessWidget {
  final characteristic;

  CharacteristicDetailSwitchWidget(this.characteristic, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('CharacteristicDetailSwitchWidget');
    return Row(
      children: <Widget>[
        Expanded(
            child: RaisedButton(
          child: Text('Ligar', style: TextStyle(fontSize: 16)),
          onPressed: () {
            BlocProvider.getBloc<DeviceBloc>()
                .writeCharacteristic(characteristic, 'on');
          },
        )),
        Expanded(
            child: RaisedButton(
          child: Text('Desligar', style: TextStyle(fontSize: 16)),
          onPressed: () {
            BlocProvider.getBloc<DeviceBloc>()
                .writeCharacteristic(characteristic, 'off');
          },
        )),
      ],
    );
  }
}
