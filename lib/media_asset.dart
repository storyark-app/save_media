import 'dart:io';

class MediaAsset {
  final File file;
  final File? pairedVideoFile;
  final bool isVideo;

  const MediaAsset(this.file, this.pairedVideoFile, this.isVideo);
}
