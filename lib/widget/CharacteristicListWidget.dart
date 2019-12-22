import 'package:flutter/material.dart';

import 'CharacteristicItemWidget.dart';

class CharacteristicListWidget extends StatelessWidget {
  final characteristics;
  const CharacteristicListWidget(this.characteristics, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("CharacteristicListWidget");
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: characteristics.length,
      itemBuilder: (BuildContext context, int index) {
        return CharacteristicItemWidget(characteristics[index]);
      },
    );
  }
}
