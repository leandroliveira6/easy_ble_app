import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/DeviceBloc.dart';
import 'package:flutter/material.dart';

class CharacteristicDetailInputWidget extends StatefulWidget {
  final characteristic;

  CharacteristicDetailInputWidget(this.characteristic, {Key key})
      : super(key: key);

  @override
  _CharacteristicDetailInputWidgetState createState() => _CharacteristicDetailInputWidgetState();
}

class _CharacteristicDetailInputWidgetState extends State<CharacteristicDetailInputWidget> {
  final _inputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('CharacteristicDetailInputWidget');
    return TextField(
      controller: _inputTextController,
      decoration: InputDecoration(
        labelText: "Valor a enviar",
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(Icons.send),
          onPressed: () =>
              BlocProvider.getBloc<DeviceBloc>().writeCharacteristic(
            widget.characteristic,
            _inputTextController.text,
          ),
        ),
      ),
    );
  }
}
