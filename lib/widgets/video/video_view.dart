import 'package:epicture/models/image.dart';
import 'package:flutter/material.dart';

class VideoViewWidget extends StatelessWidget {
  final ImageModel image;

  VideoViewWidget({
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final ratio = screenWidth / image.width;

    return Container(
      width: screenWidth,
      height: image.height * ratio,
      child: Icon(
        Icons.video_library,
        size: 64,
      ),
    );
  }
}
