import 'package:device_sensor_info/core/key_constants.dart';

import '../../domain/entities/device_info.dart';
import '../../core/platform_channel.dart';

class DeviceInfoRemoteDatasource {
  final PlatformChannel channel;
  DeviceInfoRemoteDatasource(this.channel);

  Future<DeviceInfo> fetchDeviceInfo() async {
    final info = await channel.getDeviceInfo();
    final battery = await channel.getBatteryLevel();
    return DeviceInfo(
      deviceName: info[KeysConstants.deviceName],
      osVersion: info[KeysConstants.osVersion],
      batteryLevel: battery,
    );
  }
}
