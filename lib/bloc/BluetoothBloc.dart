import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:rxdart/rxdart.dart';

class BluetoothBloc extends BlocBase {
  BleManager _bluetooth;
  Map<String, ScanResult> _deviceMap = Map<String, ScanResult>();
  BluetoothState _latestBluetoothState;

  final _bluetoothStateController = PublishSubject<bool>();
  Stream<bool> get bluetoothState => _bluetoothStateController.stream;

  final _scanResultController = PublishSubject<List>();
  Stream<List> get scanResult => _scanResultController.stream;

  BluetoothBloc() {
    _bluetooth = BleManager();
    _bluetooth.createClient().then((onValue) {
      _updateState();
    }).catchError((e) => print('Não foi possivel criar o BLE client: $e'));
    _bluetooth.observeBluetoothState().listen(_changeState);
  }

  void _updateState() async {
    BluetoothState newBluetoothState = await _bluetooth.bluetoothState();
    _changeState(newBluetoothState);
  }

  void _changeState(BluetoothState newBluetoothState) async {
    if (newBluetoothState == BluetoothState.POWERED_ON) {
      _latestBluetoothState = BluetoothState.POWERED_ON;
      _bluetoothStateController.sink.add(true);
      updateDeviceList();
    } else {
      _latestBluetoothState = BluetoothState.POWERED_OFF;
      _bluetoothStateController.sink.add(false);
    }
  }

  Future<bool> updateDeviceList() async {
    if (_latestBluetoothState == BluetoothState.POWERED_ON) {
      await _bluetooth.stopPeripheralScan();
      _scanResultController.sink.add(null);
      _deviceMap.clear();
      final scanStream = _bluetooth.startPeripheralScan().listen((ScanResult newScanResult) {
        _deviceMap.update(newScanResult.peripheral.identifier, (oldScanResult) => newScanResult, ifAbsent: () => newScanResult);
        _scanResultController.sink.add(_deviceMap.values.toList());
      });
      scanStream.onError((e) => print('Não foi possivel escanear: $e'));
      scanStream.onDone(() => scanStream.cancel());
      Future.delayed(Duration(seconds: 6), () {
        _bluetooth.stopPeripheralScan();
        _scanResultController.sink.add(_deviceMap.values.toList());
      });
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _bluetoothStateController.close();
    _scanResultController.close();
    super.dispose();
  }
}
