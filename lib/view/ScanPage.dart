import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/BluetoothBloc.dart';
import 'package:easy_ble_app/widget/DeviceListWidget.dart';
import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ScanPage');
    return Scaffold(
      appBar: AppBar(
        title: Text('EasyBLE'),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Dispositivos próximos',
            style: TextStyle(height: 2, fontSize: 20),
          ),
          Expanded(
            child: DeviceListWidget(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await BlocProvider.getBloc<BluetoothBloc>().estaLigado()) {
            BlocProvider.getBloc<BluetoothBloc>().atualizarDevices();
          } else {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: Center(child: Text('Atenção')),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'O bluetooth precisa estar ligado para efetuar essa ação.',
                          overflow: TextOverflow.clip),
                    )
                  ],
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
