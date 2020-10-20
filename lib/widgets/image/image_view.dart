import 'package:epicture/models/image.dart';
import 'package:flutter/material.dart';

class ImageViewWidget extends StatelessWidget {
  final ImageModel image;

  ImageViewWidget({
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final ratio = screenWidth / image.width;

    return Container(
      width: screenWidth,
      height: image.height * ratio,
      child: Image.network(
        image.url,
        fit: BoxFit.cover,
        loadingBuilder: _loading,
      ),
    );
  }

  Widget _loading(_, image, loading) {
    if (loading == null) return image;

    return Center(child: CircularProgressIndicator());
  }
}
