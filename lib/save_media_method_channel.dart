import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'save_media_platform_interface.dart';

/// An implementation of [SaveMediaPlatform] that uses method channels.
class MethodChannelSaveMedia extends SaveMediaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('save_media');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
