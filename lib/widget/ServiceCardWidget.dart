import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/DeviceBloc.dart';
import 'package:flutter/material.dart';

import 'CharacteristicListWidget.dart';
import 'ServiceWidget.dart';

class ServiceCardWidget extends StatelessWidget {
  final service;

  ServiceCardWidget(this.service, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ServiceCardWidget');
    return FutureBuilder(
      future: BlocProvider.getBloc<DeviceBloc>().getCharacteristics(service),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isNotEmpty) {
            return Card(
              margin: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ServiceWidget(snapshot.data.removeAt(0)),
                  CharacteristicListWidget(snapshot.data)
                ],
              ),
            );
          } else {
            return Center(child: Text('Serviço sem caracteristicas'));
          }
        }
        return Card(child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
