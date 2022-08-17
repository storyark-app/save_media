
import 'save_media_platform_interface.dart';

class SaveMedia {
  Future<String?> getPlatformVersion() {
    return SaveMediaPlatform.instance.getPlatformVersion();
  }
}
