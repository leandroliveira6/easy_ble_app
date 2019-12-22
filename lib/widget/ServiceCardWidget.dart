import 'package:flutter/material.dart';

import 'CharacteristicListWidget.dart';
import 'ServiceWidget.dart';

class ServiceCardWidget extends StatelessWidget {
  final service;

  ServiceCardWidget(this.service, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('ServiceCardWidget');
    final characteristics = service.characteristics;
    print('ServiceCardWidget characteristics: $characteristics');
    if(characteristics.isEmpty){
      return Card(child: Center(child: CircularProgressIndicator()));
    }
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ServiceWidget(characteristics.removeAt(0)),
          CharacteristicListWidget(characteristics)
        ],
      ),
    );
  }
}
