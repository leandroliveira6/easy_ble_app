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
  var _scanResult;

  @override
  void initState() {
    final bluetoothBloc = BlocProvider.getBloc<BluetoothBloc>();
    _bluetoothState = bluetoothBloc.bluetoothState;
    _scanResult = bluetoothBloc.scanResult;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bluetoothState,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return StreamBuilder(
              stream: _scanResult,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return Column(
                      children: <Widget>[
                        Text(
                          'Dispositivos próximos',
                          style: TextStyle(height: 2, fontSize: 20),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DeviceCardWidget(snapshot.data[index]);
                            },
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.gps_off, size: 260, color: Colors.grey),
                          Text(
                            'Não existem dispositivos BLE próximos. Experimente ativar o GPS.',
                            textScaleFactor: 1.2,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.bluetooth_disabled, size: 260, color: Colors.grey),
                  Text(
                    'Bluetooth desativado',
                    textScaleFactor: 1.2,
                  ),
                ],
              ),
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
