import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoApi {

static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

//android or ios
static String getOperatingSystem(){
  return '${Platform.operatingSystem}';
}



//device manufacturer and model
  static Future<String?> getDeviceInfo() async {
    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      return '${info.manufacturer} - ${info.model}';
    } else if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return '${info.name} - ${info.model}';
    } else {
      return null;
    }
  }

//operating system version ex: android API 28
   static Future<String?> getOperatingSystemVersion() async {
    if (Platform.isAndroid) {
      final info = await _deviceInfo.androidInfo;
      return '${info.version.sdkInt}';
    } else if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return '${info.systemVersion}';
    } else {
      return null;
    }
  }
}
