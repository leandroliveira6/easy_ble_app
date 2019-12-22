import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'bloc/BluetoothBloc.dart';
import 'bloc/DeviceBloc.dart';
import 'view/ScanPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => BluetoothBloc()),
        Bloc((i) => DeviceBloc()),
      ],
      child: MaterialApp(
        title: 'EasyBLE',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ScanPage(),
      ),
    );
  }
}
