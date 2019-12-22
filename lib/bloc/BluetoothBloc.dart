import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:rxdart/rxdart.dart';

enum ScanState { procurando, pronto }

class BluetoothBloc extends BlocBase {
  FlutterBlue _bluetooth;

  final _stateController = PublishSubject<bool>();
  Stream<bool> get state => _stateController.stream;
  Sink<bool> get _updateState => _stateController.sink;

  final _scanController = PublishSubject<ScanState>();
  Stream<ScanState> get scanState => _scanController.stream;
  Sink<ScanState> get _updateScanState => _scanController.sink;

  final _scanResultController = PublishSubject<List>();
  Stream<List> get scanResult => _scanResultController.stream;
  Sink<List> get _updateScanResult => _scanResultController.sink;

  BluetoothBloc() {
    _bluetooth = FlutterBlue.instance;
    _bluetooth.state.listen(_atualizarEstado);

    estaLigado().then((state) {
      _updateState.add(state);
    });

    _bluetooth.scanResults.listen((scanResult) {
      print('DeviceBloc scanResults listen');
      _updateScanResult.add(scanResult);
      _updateScanState.add(ScanState.pronto);
    });
  }

  void _atualizarEstado(estado) {
    if (estado == BluetoothState.on) {
      _updateState.add(true);
      atualizarDevices();
    } else if (estado == BluetoothState.off) {
      _updateState.add(false);
    }
  }

  Future<bool> estaLigado() {
    return _bluetooth.isOn;
  }

  void atualizarDevices() {
    print('DeviceBloc  atualizarDevices');
    _updateScanState.add(ScanState.procurando);
    _bluetooth.stopScan();
    _bluetooth.startScan(timeout: Duration(seconds: 5)).whenComplete(() {
      _bluetooth.stopScan();
    });
  }

  @override
  void dispose() {
    _stateController.close();
    _scanController.close();
    _scanResultController.close();
    super.dispose();
  }
}
