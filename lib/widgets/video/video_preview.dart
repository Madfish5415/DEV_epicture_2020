import 'package:epicture/models/image.dart';
import 'package:flutter/material.dart';

class VideoPreviewWidget extends StatelessWidget {
  final ImageModel image;

  VideoPreviewWidget({
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.video_library,
      size: 64,
    );
  }
}
