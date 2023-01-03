import 'dart:io';

class MediaAsset {
  final File file;
  final File? pairedVideoFile;
  final bool isVideo;
  final DateTime createdAt;

  const MediaAsset({
    required this.file,
    this.pairedVideoFile,
    required this.isVideo,
    required this.createdAt,
  });
}
