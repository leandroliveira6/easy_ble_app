import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:rxdart/rxdart.dart';

enum DeviceState { conectado, conectando, desconectado, erro, incompativel }

class DeviceBloc extends BlocBase {
  List _characteristicStreamControllers = List();
  Map _connectedDevices = Map();
  final _deviceStateController = BehaviorSubject<DeviceState>();
  Stream<DeviceState> get deviceState => _deviceStateController.stream;

  void checkDeviceState(Peripheral device) async {
    if (await device.isConnected()) {
      _deviceStateController.sink.add(DeviceState.conectado);
    } else {
      _deviceStateController.sink.add(DeviceState.desconectado);
    }
  }

  void _updateDeviceState(DeviceState newDeviceState) {
    _deviceStateController.sink.add(newDeviceState);
  }

  void connectDevice(Peripheral device) async {
    if (device.name.startsWith('EasyBLE')) {
      _updateDeviceState(DeviceState.conectando);
      device
          .connect()
          .then((onValue) => _deviceConnected(device))
          .catchError((onError) => _updateDeviceState(DeviceState.erro))
          .timeout(Duration(seconds: 10),
              onTimeout: () => _updateDeviceState(DeviceState.erro));
    } else {
      _updateDeviceState(DeviceState.incompativel);
    }
  }

  Future<bool> disconnectDevice(Peripheral device) async {
    if (await device.isConnected()) {
      await device
          .disconnectOrCancelConnection()
          .then((onValue) => _updateDeviceState(DeviceState.desconectado))
          .catchError(
              (onError) => print('Erro ao desconectar device: $onError'));
      return true;
    }
    return false;
  }

  void _deviceConnected(Peripheral device) {
    _updateDeviceState(DeviceState.conectado);
    _connectedDevices[device.identifier] = device.observeConnectionState();
  }

  Stream getDeviceConnectionState(Peripheral device) {
    if (_connectedDevices.containsKey(device.identifier)) {
      return _connectedDevices[device.identifier];
    }
    return null;
  }

  Future<List<Service>> getServices(Peripheral device) async {
    await device.discoverAllServicesAndCharacteristics();
    return await device.services();
  }

  Future<List<Characteristic>> getCharacteristics(Service service) async {
    return await service.characteristics();
  }

  Future<List<String>> getDescriptors(Characteristic characteristic) async {
    final descriptors = await characteristic.service
        .descriptorsForCharacteristic(characteristic.uuid);
    List<String> decodedDescriptorsValues = List<String>();
    for (var descriptor in descriptors) {
      decodedDescriptorsValues.add(await readDescriptor(descriptor));
    }
    return decodedDescriptorsValues;
  }

  Future<String> readDescriptor(Descriptor descriptor) async {
    return utf8.decode(await descriptor.read());
  }

  void writeCharacteristic(Characteristic characteristic, String value) async {
    if (await characteristic.service.peripheral.isConnected()) {
      await characteristic.write(utf8.encode(value), false);
    }
  }

  Stream getCharacteristicStream(Characteristic characteristic) {
    final characteristicStreamController = PublishSubject();
    characteristic.monitor().listen((valorCodificado) {
      characteristicStreamController.sink.add(utf8.decode(valorCodificado));
    });
    _characteristicStreamControllers.add(characteristicStreamController);
    return characteristicStreamController.stream;
  }

  @override
  void dispose() {
    _deviceStateController.close();
    for (var characteristicStreamController
        in _characteristicStreamControllers) {
      characteristicStreamController.close();
    }
    super.dispose();
  }
}
