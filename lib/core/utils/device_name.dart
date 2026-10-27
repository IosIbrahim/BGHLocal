
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

Future<String> resolveComputerName() async {
  final deviceInfo = DeviceInfoPlugin();
  try {
    if (kIsWeb) {
      final webInfo = await deviceInfo.webBrowserInfo;
      // return webInfo.userAgent ?? "Web Browser";
      return "Web Browser";
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model ?? "Unknown Android Device";
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return iosInfo.name ?? "Unknown iOS Device";
    } else {
      return "Unsupported Platform";
    }
  } catch (_) {}
  return 'Dashboard';
}


Future<String> getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();

  if (kIsWeb) {
    final webInfo = await deviceInfo.webBrowserInfo;
    return webInfo.vendor ?? (webInfo.userAgent ?? "web");
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id ?? "";
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor ?? "";
  } else {
    return "Unsupported Platform";
  }
}
