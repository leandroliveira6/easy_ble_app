import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:easy_ble_app/bloc/DeviceBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

import 'CharacteristicDetailInputWidget.dart';
import 'CharacteristicDetailOutputWidget.dart';
import 'CharacteristicDetailSwitchWidget.dart';

class CharacteristicItemWidget extends StatelessWidget {
  final characteristic;

  CharacteristicItemWidget(this.characteristic, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('CharacteristicItemWidget');
    return FutureBuilder(
      future: BlocProvider.getBloc<DeviceBloc>().getDescriptors(characteristic),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Widget detail;
          if (characteristic.isReadable) {
            detail = CharacteristicDetailOutputWidget(characteristic);
          } else if (characteristic.isWritableWithResponse) {
            detail = CharacteristicDetailInputWidget(characteristic);
          } else if (characteristic.isWritableWithoutResponse) {
            detail = CharacteristicDetailSwitchWidget(characteristic);
          }

          return Container(
            //decoration: BoxDecoration(border: Border(top: BorderSide())),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    snapshot.data[0], //Text(snapshot.data[0],
                    overflow: TextOverflow.clip,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: Center(child: Text('Informativo')),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    snapshot.data[1], //Text(snapshot.data[1],
                                    overflow: TextOverflow.clip),
                              )
                            ],
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

    // var list = [
    //   CharacteristicDetailInputWidget(characteristic),
    //   CharacteristicDetailOutputWidget(characteristic),
    //   CharacteristicDetailSwitchWidget(characteristic)
    // ];
    // list.shuffle();
    // return Container(
    //   decoration: BoxDecoration(border: Border(top: BorderSide())),
    //   padding: const EdgeInsets.all(8.0),
    //   child: Column(
    //     children: <Widget>[
    //       ListTile(
    //         title: Text('$characteristic', overflow: TextOverflow.clip),
    //         trailing: IconButton(
    //           icon: Icon(Icons.info),
    //           onPressed: () {
    //             showDialog<void>(
    //               context: context,
    //               builder: (BuildContext context) {
    //                 return SimpleDialog(
    //                   title: Center(child: Text('Informativo')),
    //                   children: <Widget>[
    //                     Padding(
    //                       padding: const EdgeInsets.all(8.0),
    //                       child: Text('$characteristic',
    //                           overflow: TextOverflow.clip),
    //                     )
    //                   ],
    //                 );
    //               },
    //             );
    //           },
    //         ),
    //       ),
    //       list[0],
    //     ],
    //   ),
    // );
  }
}
