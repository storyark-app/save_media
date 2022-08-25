import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:save_media/media_asset.dart';

import 'save_media_platform_interface.dart';

/// An implementation of [SaveMediaPlatform] that uses method channels.
class MethodChannelSaveMedia extends SaveMediaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('save_media');

  @override
  Future<bool> saveMediaAssets(List<MediaAsset> mediaAssets) async {
    return await methodChannel.invokeMethod(
      'saveMediaAssets',
      mediaAssets.map(_encodeMediaAsset).toList(),
    );
  }

  Map<String, dynamic> _encodeMediaAsset(MediaAsset item) => {
        'filePath': item.file.path,
        'pairedVideoFilePath': item.pairedVideoFile?.path,
        'isVideo': item.isVideo
      };
}
