import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'liman_method_channel.dart';

abstract class LimanPlatform extends PlatformInterface {
  /// Constructs a LimanPlatform.
  LimanPlatform() : super(token: _token);

  static final Object _token = Object();

  static LimanPlatform _instance = MethodChannelLiman();

  /// The default instance of [LimanPlatform] to use.
  ///
  /// Defaults to [MethodChannelLiman].
  static LimanPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LimanPlatform] when
  /// they register themselves.
  static set instance(LimanPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
