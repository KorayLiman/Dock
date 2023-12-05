import 'package:envied/envied.dart';

part 'envied.g.dart';

@Envied(path: '.env')
abstract final class Env {
  @EnviedField(varName: 'TEST_BASE_URL', obfuscate: true)
  static final String testBaseUrl = _Env.testBaseUrl;
  @EnviedField(varName: 'LIVE_BASE_URL', obfuscate: true)
  static final String liveBaseUrl = _Env.liveBaseUrl;
}
