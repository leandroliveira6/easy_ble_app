import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/DeviceBloc.dart';
import 'package:flutter/material.dart';

class CharacteristicDetailOutputWidget extends StatelessWidget {
  final _inputTextController = TextEditingController();
  final characteristic;

  CharacteristicDetailOutputWidget(this.characteristic, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('CharacteristicDetailOutputWidget');
    return StreamBuilder(
      stream: BlocProvider.getBloc<DeviceBloc>()
          .getCharacteristicStream(characteristic),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _inputTextController.text = snapshot.data;
          return TextField(
            readOnly: true,
            controller: _inputTextController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Valor',
            ),
          );

          // Row(children: <Widget>[
          //   Expanded(
          //       child: Text('Valor:', style: TextStyle(fontSize: 20))),
          //   Expanded(
          //       child: Text(snapshot.data, style: TextStyle(fontSize: 20))),
          // ]);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
