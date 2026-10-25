import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> resolveComputerName() async {
  final plugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      final info = await plugin.androidInfo;
      return '${info.manufacturer} ${info.model}'.trim();
    }
    if (Platform.isIOS) {
      final info = await plugin.iosInfo;
      return info.utsname.machine.isNotEmpty ? info.utsname.machine : info.name;
    }
  } catch (_) {}
  return 'FlutterPatient';
}
