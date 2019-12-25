import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/DeviceBloc.dart';
import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  final characteristic;

  ServiceWidget(this.characteristic, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BlocProvider.getBloc<DeviceBloc>().getDescriptors(characteristic),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          String serviceName, serviceDescription;
          if (snapshot.data.length < 2) {
            serviceName = 'Nome para o serviço não fornecido';
            serviceDescription = 'Descrição para o serviço não fornecida';
          } else {
            serviceName = snapshot.data[0];
            serviceDescription = snapshot.data[1];
          }
          
          return ListTile(
            title: Text(
              serviceName,
              overflow: TextOverflow.clip,
              softWrap: false,
            ),
            subtitle: Text(serviceDescription),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
