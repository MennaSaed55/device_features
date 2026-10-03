import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  const DeviceInfo({required this.model, required this.osVersion});

  final String model;
  final String osVersion;
}

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<DeviceInfo> loadDeviceInfo() async {
    if (Platform.isAndroid) {
      final info = await _deviceInfoPlugin.androidInfo;
      return DeviceInfo(
        model: '${info.manufacturer} ${info.model}',
        osVersion: 'Android ${info.version.release}',
      );
    }

    if (Platform.isIOS) {
      final info = await _deviceInfoPlugin.iosInfo;
      return DeviceInfo(
        model: info.modelName,
        osVersion: '${info.systemName} ${info.systemVersion}',
      );
    }

    throw UnsupportedError('Device info is only supported on Android and iOS.');
  }
}
