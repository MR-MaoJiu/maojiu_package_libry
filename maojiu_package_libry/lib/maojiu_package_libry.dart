import 'dart:async';

import 'package:flutter/services.dart';

class MaojiuPackageLibry {
  static const MethodChannel _channel =
      const MethodChannel('maojiu_package_libry');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
