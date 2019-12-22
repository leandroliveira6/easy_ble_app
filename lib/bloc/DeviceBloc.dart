import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:rxdart/rxdart.dart';

enum DeviceState { conectado, conectando, desconectado, erro, incompativel }

class DeviceBloc extends BlocBase {
  Map<DeviceIdentifier, bool> _devicesState = Map<DeviceIdentifier, bool>();

  final _stateController = BehaviorSubject<DeviceState>();
  Stream<DeviceState> get state => _stateController.stream;
  Sink<DeviceState> get _updateState => _stateController.sink;

  void conectarDevice(BluetoothDevice device) {
    _updateState.add(DeviceState.conectando);
    if (_devicesState.containsKey(device.id) && _devicesState[device.id]) {
      _updateState.add(DeviceState.conectado);
    } else {
      device.connect(autoConnect: false).then((onData) {
        if (device.type == BluetoothDeviceType.le &&
            device.name.startsWith('EasyBLE')) {
          _updateState.add(DeviceState.conectado);
          _devicesState[device.id] = true;
        } else {
          _updateState.add(DeviceState.incompativel);
          device.disconnect();
        }
      }).catchError((onError) {
        _updateState.add(DeviceState.erro);
      }).timeout(Duration(seconds: 5), onTimeout: () {
        _updateState.add(DeviceState.erro);
      });
    }
  }

  void desconectarDevice(BluetoothDevice device) {
    _updateState.add(DeviceState.conectando);
    if (_devicesState.containsKey(device.id) && !_devicesState[device.id]) {
      _updateState.add(DeviceState.desconectado);
    } else {
      device.disconnect().then((onData) {
        _updateState.add(DeviceState.desconectado);
        _devicesState[device.id] = false;
      }).catchError(_deviceErro);
    }
  }

  void _deviceErro(onError) {
    _updateState.add(DeviceState.erro);
  }

  Future<List> obterServicos(device) {
    return device.discoverServices();
  }

  bool estaConectado(device) {
    if (_devicesState.containsKey(device.id) && _devicesState[device.id]) {
      return true;
    } else {
      return false;
    }
  }

  void atualizarEstado(device) {
    print('DeviceBloc atualizarEstado');
    if (estaConectado(device)) {
      _updateState.add(DeviceState.conectado);
    } else {
      _updateState.add(DeviceState.desconectado);
    }
  }

  @override
  void dispose() {
    _stateController.close();
    super.dispose();
  }
}
