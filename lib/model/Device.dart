class Device {
  var instance;

  Device(this.instance);
  
  get name{
    return instance?.device?.name;
  }

  get rssi{
    return instance?.rssi;
  }
}