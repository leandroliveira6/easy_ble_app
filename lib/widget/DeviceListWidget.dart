import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/BluetoothBloc.dart';
import 'package:flutter/material.dart';

import 'DeviceCardWidget.dart';

class DeviceListWidget extends StatefulWidget {
  DeviceListWidget({Key key}) : super(key: key);

  @override
  _DeviceListWidgetState createState() => _DeviceListWidgetState();
}

class _DeviceListWidgetState extends State<DeviceListWidget> {
  var _bluetoothState;
  var _scanState;
  var _scanResult;

  @override
  void initState() {
    final bluetoothBloc = BlocProvider.getBloc<BluetoothBloc>();
    _bluetoothState = bluetoothBloc.state;
    _scanState = bluetoothBloc.scanState;
    _scanResult = bluetoothBloc.scanResult;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('DeviceListWidget');
    return StreamBuilder(
      stream: _bluetoothState,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return StreamBuilder(
              stream: _scanState,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == ScanState.pronto) {
                    return StreamBuilder(
                      stream: _scanResult,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.isNotEmpty) {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return DeviceCardWidget(snapshot.data[index]);
                              },
                            );
                          } else {
                            return Center(
                                child: Text(
                                    'Não existem dispositivos BLE próximos.'));
                          }
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    );
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          } else {
            return Center(
                child: Text(
                    'Não é possivel exibir a lista de dispositivos BLE próximos com o bluetooth do aparelho desativado. '
                    'Por favor, ative o bluetooth e pressione o botão de atualizar.'));
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
