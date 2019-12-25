import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/DeviceBloc.dart';
import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  final characteristic;

  ServiceWidget(this.characteristic, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ServiceWidget');
    return FutureBuilder(
      future: BlocProvider.getBloc<DeviceBloc>().getDescriptors(characteristic),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return ListTile(
            title: Text(
              snapshot.data[0],
              overflow: TextOverflow.clip,
              softWrap: false,
            ), //Text(snapshot.data[0]),
            subtitle: Text(snapshot.data[1]), //Text(snapshot.data[1]),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
