import 'package:epicture/models/album.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/models/image.dart';
import 'package:epicture/widgets/model/image_view.dart';
import 'package:epicture/widgets/model/video_view.dart';
import 'package:epicture/widgets/utility/icon_text.dart';
import 'package:flutter/material.dart';

class GalleryItemViewWidget extends StatelessWidget {
  final GalleryItemModel galleryItem;

  GalleryItemViewWidget({
    @required this.galleryItem,
  });

  @override
  Widget build(BuildContext context) {
    final List<ImageModel> images = [];
    (galleryItem.child is AlbumModel)
        ? images.addAll(galleryItem.child.images)
        : images.add(galleryItem.child);

    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            _GalleryItemViewImage(image: images[index]),
            _GalleryItemViewImageBottom(image: images[index]),
          ],
        );
      },
    );
  }
}

class _GalleryItemViewImage extends StatelessWidget {
  final ImageModel image;

  _GalleryItemViewImage({
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    if (image.type.contains("video")) {
      return VideoViewWidget(image: image);
    }

    return ImageViewWidget(image: image);
  }
}

class _GalleryItemViewImageBottom extends StatelessWidget {
  final ImageModel image;

  _GalleryItemViewImageBottom({
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconTextWidget(
            icon: Icon(Icons.visibility),
            text: Text(image.views.toString()),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.file_download),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
