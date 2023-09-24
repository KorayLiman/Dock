import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'liman_platform_interface.dart';

/// An implementation of [LimanPlatform] that uses method channels.
class MethodChannelLiman extends LimanPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('liman');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
