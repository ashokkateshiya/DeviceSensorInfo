import 'package:device_sensor_info/core/channel_constants.dart';
import 'package:device_sensor_info/core/key_constants.dart';
import 'package:flutter/services.dart';

class PlatformChannel {
  static const _channel = MethodChannel(ChannelConstants.deviceInfoChannel);

  Future<Map<String, dynamic>> getDeviceInfo() async =>
      Map<String, dynamic>.from(
        await _channel.invokeMethod(ChannelConstants.methodGetDeviceInfo),
      );

  Future<int> getBatteryLevel() async =>
      await _channel.invokeMethod<int>(
        ChannelConstants.methodGetBatteryLevel,
      ) ??
      0;

  Future<void> toggleFlashlight(bool status) async =>
      await _channel.invokeMethod(ChannelConstants.methodToggleFlashlight, {
        KeysConstants.status: status,
      });

  Future<Map<String, dynamic>> getGyroscopeData() async =>
      Map<String, dynamic>.from(
        await _channel.invokeMethod(ChannelConstants.methodGetGyroscopeData),
      );
}
