import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/DeviceBloc.dart';
import 'package:easy_ble_app/widget/ServiceListWidget.dart';
import 'package:flutter/material.dart';

class DevicePage extends StatefulWidget {
  final device;

  DevicePage(this.device, {Key key}) : super(key: key);

  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  var deviceState;

  @override
  void initState() {
    print('teste');
    final deviceBloc = BlocProvider.getBloc<DeviceBloc>();
    deviceState = deviceBloc.state;
    deviceBloc.atualizarEstado(widget.device);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('DevicePage');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
        actions: <Widget>[
          StreamBuilder(
            stream: deviceState,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data == DeviceState.conectado) {
                return IconButton(
                  icon: Icon(Icons.check_box, color: Colors.greenAccent),
                  onPressed: () {
                    setState(() {
                      BlocProvider.getBloc<DeviceBloc>()
                          .desconectarDevice(widget.device);
                    });
                  },
                );
              }
              return IconButton(
                icon: Icon(Icons.check_box_outline_blank),
                onPressed: () {
                  setState(() {
                    BlocProvider.getBloc<DeviceBloc>()
                        .conectarDevice(widget.device);
                  });
                },
              );
            },
          ),
        ],
      ),
      body: ServiceListWidget(widget.device),
    );
  }
}
