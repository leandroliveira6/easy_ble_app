import 'package:bloc_pattern/bloc_pattern.dart';
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
    deviceState = deviceBloc.state;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('ServiceListWidget');
    return StreamBuilder(
      stream: deviceState,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('ServiceListWidget deviceState');
        if (snapshot.hasData) {
          print('ServiceListWidget deviceState ${snapshot.data}');
          if (snapshot.data == DeviceState.conectado) {
            return FutureBuilder(
              future: deviceBloc.obterServicos(widget.device),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ServiceCardWidget(snapshot.data[index]);
                      },
                    );
                  } else {
                    return Center(
                        child: Text('Não há serviços para este dispositivo'));
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          } else if (snapshot.data == DeviceState.desconectado) {
            return Center(child: Text('Dispositivo desconectado'));
          } else if (snapshot.data == DeviceState.incompativel) {
            return Center(
                child: Text('Dispositivo incompativel com a aplicação'));
          } else if (snapshot.data == DeviceState.erro) {
            return Center(
                child: Text('Erro ao tentar se conectar ao dispositivo'));
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}