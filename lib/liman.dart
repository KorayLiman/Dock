
import 'liman_platform_interface.dart';

class Liman {
  Future<String?> getPlatformVersion() {
    return LimanPlatform.instance.getPlatformVersion();
  }
}
