import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  final characteristic;

  ServiceWidget(this.characteristic, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ServiceWidget');
    final descriptors = characteristic.descriptors;
    if (descriptors.length != 2) {
      return Center(
        child: Text('Informações do serviço inválidas'),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('${descriptors[0].value}',
            overflow: TextOverflow.clip,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Text('${descriptors[1].value}',
            overflow: TextOverflow.clip,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
