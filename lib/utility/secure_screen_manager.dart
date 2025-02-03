import 'package:flutter/services.dart';

class SecureScreenManager {
  static const _channel =
      MethodChannel('com.nscspl.mbanking.hpscb.securescreen');

  static Future<void> enableSecureScreen() async {
    await _channel.invokeMethod('enableSecureScreen');
  }

  static Future<void> disableSecureScreen() async {
    await _channel.invokeMethod('disableSecureScreen');
  }
}
