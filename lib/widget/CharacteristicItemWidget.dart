import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'CharacteristicDetailInputWidget.dart';
import 'CharacteristicDetailOutputWidget.dart';
import 'CharacteristicDetailSwitchWidget.dart';

class CharacteristicItemWidget extends StatelessWidget {
  final characteristic;

  CharacteristicItemWidget(this.characteristic, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('CharacteristicItemWidget');
    final descriptors = characteristic.descriptors;
    if (descriptors.length != 3) {
      return Center(child: Text('Informações da característica invalidas.'));
    }
    return Text('${descriptors.last.value}');

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
