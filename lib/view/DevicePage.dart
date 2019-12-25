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
    final deviceBloc = BlocProvider.getBloc<DeviceBloc>();
    deviceState = deviceBloc.deviceState;
    deviceBloc.checkDeviceState(widget.device);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
        actions: <Widget>[
          StreamBuilder(
            stream: deviceState,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data == DeviceState.conectado) {
                BlocProvider.getBloc<DeviceBloc>()
                    .getDeviceConnectionState(widget.device)
                    .handleError((onError) {
                  Navigator.pop(context);
                });
                return IconButton(
                  icon: Icon(Icons.bluetooth_connected, color: Colors.greenAccent),
                  onPressed: () async {
                    var desconectou = await BlocProvider.getBloc<DeviceBloc>()
                        .disconnectDevice(widget.device);
                    if (!desconectou) {
                      setState(() {
                        Navigator.pop(context);
                      });
                    }
                  },
                );
              }
              return IconButton(
                icon: Icon(Icons.bluetooth_audio),
                onPressed: () {
                  setState(() {
                    BlocProvider.getBloc<DeviceBloc>()
                        .connectDevice(widget.device);
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
