import 'package:epicture/models/album.dart';
import 'package:epicture/models/image.dart';
import 'package:epicture/widgets/image/image_preview.dart';
import 'package:flutter/material.dart';

class AlbumPreviewWidget extends StatelessWidget {
  final AlbumModel album;

  AlbumPreviewWidget({
    @required this.album,
  });

  @override
  Widget build(BuildContext context) {
    final ImageModel image = album.images.firstWhere((element) {
      return (element.id == album.coverId);
    });

    return ImagePreviewWidget(image: image);
  }
}
