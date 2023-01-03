import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'media_asset.dart';
import 'save_media_platform_interface.dart';

export 'media_asset.dart';

class SaveMedia {
  Future<bool> saveMediaAssets(List<MediaAsset> mediaAssets) async {
    if (Platform.isAndroid || Platform.isIOS) {
      return SaveMediaPlatform.instance.saveMediaAssets(mediaAssets);
    }

    final downloadsPath = (await getDownloadsDirectory())!.path;
    for (final asset in mediaAssets) {
      var filename =
          '${asset.createdAt.year}_${asset.createdAt.month}_${asset.createdAt.day}_${p.basename(asset.file.path)}';
      final newPath = p.join(downloadsPath, filename);
      await asset.file.copy(newPath);
    }
    return true;
  }
}
