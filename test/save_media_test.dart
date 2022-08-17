import 'package:flutter_test/flutter_test.dart';
import 'package:save_media/save_media.dart';
import 'package:save_media/save_media_platform_interface.dart';
import 'package:save_media/save_media_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSaveMediaPlatform 
    with MockPlatformInterfaceMixin
    implements SaveMediaPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SaveMediaPlatform initialPlatform = SaveMediaPlatform.instance;

  test('$MethodChannelSaveMedia is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSaveMedia>());
  });

  test('getPlatformVersion', () async {
    SaveMedia saveMediaPlugin = SaveMedia();
    MockSaveMediaPlatform fakePlatform = MockSaveMediaPlatform();
    SaveMediaPlatform.instance = fakePlatform;
  
    expect(await saveMediaPlugin.getPlatformVersion(), '42');
  });
}
