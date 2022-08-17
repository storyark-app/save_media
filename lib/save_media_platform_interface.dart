import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'save_media_method_channel.dart';

abstract class SaveMediaPlatform extends PlatformInterface {
  /// Constructs a SaveMediaPlatform.
  SaveMediaPlatform() : super(token: _token);

  static final Object _token = Object();

  static SaveMediaPlatform _instance = MethodChannelSaveMedia();

  /// The default instance of [SaveMediaPlatform] to use.
  ///
  /// Defaults to [MethodChannelSaveMedia].
  static SaveMediaPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SaveMediaPlatform] when
  /// they register themselves.
  static set instance(SaveMediaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
