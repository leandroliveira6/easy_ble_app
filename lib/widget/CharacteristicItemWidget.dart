import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/DeviceBloc.dart';
import 'package:flutter/material.dart';

import 'CharacteristicDetailInputWidget.dart';
import 'CharacteristicDetailOutputWidget.dart';
import 'CharacteristicDetailSwitchWidget.dart';

class CharacteristicItemWidget extends StatelessWidget {
  final characteristic;

  CharacteristicItemWidget(this.characteristic, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BlocProvider.getBloc<DeviceBloc>().getDescriptors(characteristic),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          String characteristicName, characteristicDescription;
          if (snapshot.data.length < 2) {
            characteristicName = 'Nome para a característica não fornecido';
            characteristicDescription = 'Descrição para a característica não fornecida';
          } else {
            characteristicName = snapshot.data[0];
            characteristicDescription = snapshot.data[1];
          }

          Widget detail;
          if (characteristic.isReadable) {
            detail = CharacteristicDetailOutputWidget(characteristic);
          } else if (characteristic.isWritableWithoutResponse) {
            detail = CharacteristicDetailInputWidget(characteristic);
          } else if (characteristic.isWritableWithResponse) {
            detail = CharacteristicDetailSwitchWidget(characteristic);
          }

          return Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    characteristicName,
                    overflow: TextOverflow.clip,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Informativo',
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.5,
                            ),
                            content: Text(
                              characteristicDescription,
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.2,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                detail
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
