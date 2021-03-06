import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/BluetoothBloc.dart';
import 'package:easy_ble_app/bloc/DeviceBloc.dart';
import 'package:flutter/material.dart';

import 'ServiceCardWidget.dart';

class ServiceListWidget extends StatefulWidget {
  final device;

  ServiceListWidget(this.device, {Key key}) : super(key: key);

  @override
  _ServiceListWidgetState createState() => _ServiceListWidgetState();
}

class _ServiceListWidgetState extends State<ServiceListWidget> {
  DeviceBloc deviceBloc;
  var deviceState;
  var deviceServices;

  @override
  void initState() {
    deviceBloc = BlocProvider.getBloc<DeviceBloc>();
    deviceState = deviceBloc.deviceState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: deviceState,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == DeviceState.conectado) {
            return FutureBuilder(
              future: deviceBloc.getServices(widget.device),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    final servicos = snapshot.data
                        .getRange(2, snapshot.data.length)
                        .toList();
                    return ListView.builder(
                      itemCount: servicos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ServiceCardWidget(servicos[index]);
                      },
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.widgets, size: 260, color: Colors.grey),
                          Text(
                            'Não há serviços para este dispositivo',
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
          } else if (snapshot.data == DeviceState.desconectado) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.bluetooth, size: 260, color: Colors.grey),
                  Text(
                    'Dispositivo desconectado',
                    textScaleFactor: 1.2,
                  ),
                ],
              ),
            );
          } else if (snapshot.data == DeviceState.incompativel) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.device_unknown, size: 260, color: Colors.grey),
                  Text(
                    'Dispositivo incompativel com a aplicação',
                    textScaleFactor: 1.2,
                  ),
                ],
              ),
            );
          } else if (snapshot.data == DeviceState.erro) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.error_outline, size: 260, color: Colors.redAccent),
                  Text(
                    'Erro ao tentar se conectar ao dispositivo',
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
