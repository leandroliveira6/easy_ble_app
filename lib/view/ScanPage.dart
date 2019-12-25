import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/BluetoothBloc.dart';
import 'package:easy_ble_app/widget/DeviceListWidget.dart';
import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyBLE'),
      ),
      body: DeviceListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!await BlocProvider.getBloc<BluetoothBloc>().updateDeviceList()) {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Atenção',
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.5,
                  ),
                  content: Text(
                    'O bluetooth precisa estar ativado para efetuar essa ação.',
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.2,
                  ),
                );
              },
            );
          }
        },
        tooltip: 'Atualizar',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
