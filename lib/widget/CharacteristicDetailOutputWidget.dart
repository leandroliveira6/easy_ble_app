import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/DeviceBloc.dart';
import 'package:flutter/material.dart';

class CharacteristicDetailOutputWidget extends StatefulWidget {
  final characteristic;

  CharacteristicDetailOutputWidget(this.characteristic, {Key key})
      : super(key: key);

  @override
  _CharacteristicDetailOutputWidgetState createState() =>
      _CharacteristicDetailOutputWidgetState();
}

class _CharacteristicDetailOutputWidgetState
    extends State<CharacteristicDetailOutputWidget> {
  final _inputTextController = TextEditingController();
  var characteristicStream;

  @override
  void initState() {
    characteristicStream = BlocProvider.getBloc<DeviceBloc>()
        .getCharacteristicStream(widget.characteristic);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('CharacteristicDetailOutputWidget');
    return StreamBuilder(
      stream: characteristicStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _inputTextController.text = snapshot.data;
          return TextField(
            readOnly: true,
            controller: _inputTextController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Valor recebido',
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
