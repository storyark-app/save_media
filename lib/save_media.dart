import 'media_asset.dart';
import 'save_media_platform_interface.dart';

export 'media_asset.dart';

class SaveMedia {

  Future<bool> saveMediaAssets(List<MediaAsset> mediaAssets) {
    return SaveMediaPlatform.instance.saveMediaAssets(mediaAssets);
  }
}
