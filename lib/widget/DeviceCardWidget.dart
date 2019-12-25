import 'package:easy_ble_app/view/DevicePage.dart';
import 'package:flutter/material.dart';

class DeviceCardWidget extends StatelessWidget {
  final scanResult;

  const DeviceCardWidget(this.scanResult, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('DeviceCardWidget');
    return Card(
      child: ListTile(
        title: Text(scanResult.peripheral.name),
        subtitle: Text('${scanResult.rssi}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DevicePage(scanResult.peripheral)),
          );
        },
      ),
    );
  }
}
