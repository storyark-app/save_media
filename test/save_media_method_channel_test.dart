import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:save_media/save_media_method_channel.dart';

void main() {
  MethodChannelSaveMedia platform = MethodChannelSaveMedia();
  const MethodChannel channel = MethodChannel('save_media');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
