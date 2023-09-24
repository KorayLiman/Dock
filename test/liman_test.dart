import 'package:flutter_test/flutter_test.dart';
import 'package:liman/liman.dart';
import 'package:liman/liman_platform_interface.dart';
import 'package:liman/liman_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLimanPlatform
    with MockPlatformInterfaceMixin
    implements LimanPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LimanPlatform initialPlatform = LimanPlatform.instance;

  test('$MethodChannelLiman is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLiman>());
  });

  test('getPlatformVersion', () async {
    Liman limanPlugin = Liman();
    MockLimanPlatform fakePlatform = MockLimanPlatform();
    LimanPlatform.instance = fakePlatform;

    expect(await limanPlugin.getPlatformVersion(), '42');
  });
}
