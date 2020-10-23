import 'package:epicture/models/album.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/router.dart';
import 'package:epicture/widgets/album/album_preview.dart';
import 'package:epicture/widgets/icon/icon_text.dart';
import 'package:epicture/widgets/image/image_preview.dart';
import 'package:epicture/widgets/utility/elevation.dart';
import 'package:flutter/material.dart';

class GalleryItemCard extends StatelessWidget {
  final GalleryItemModel galleryItem;

  GalleryItemCard({
    @required this.galleryItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Column(
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: _GalleryItemCardImage(child: galleryItem.child),
              ),
              Expanded(
                child: _GalleryItemCardBottom(galleryItem: galleryItem),
              ),
            ],
          ),
          _GalleryItemCardInkWell(galleryItem: galleryItem),
        ],
      ),
    );
  }
}

class _GalleryItemCardImage extends StatelessWidget {
  final dynamic child;

  _GalleryItemCardImage({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (child is AlbumModel) {
      return AlbumPreviewWidget(album: child);
    }

    return ImagePreviewWidget(image: child);
  }
}

class _GalleryItemCardBottom extends StatelessWidget {
  final GalleryItemModel galleryItem;

  _GalleryItemCardBottom({
    @required this.galleryItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            galleryItem.child.title ?? "No title",
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
          Row(
            children: [
              IconTextWidget(
                icon: Icon(Icons.favorite_border, size: 16),
                text: Text(galleryItem.favorites?.toString() ?? "0"),
              ),
              IconTextWidget(
                icon: Icon(Icons.arrow_upward, size: 16),
                text: Text(galleryItem.ups?.toString() ?? "0"),
              ),
              IconTextWidget(
                icon: Icon(Icons.arrow_downward, size: 16),
                text: Text(galleryItem.downs?.toString() ?? "0"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GalleryItemCardInkWell extends StatelessWidget {
  final GalleryItemModel galleryItem;

  _GalleryItemCardInkWell({
    @required this.galleryItem,
  });

  @override
  Widget build(BuildContext context) {
    return ElevationWidget(
      child: InkWell(
        splashColor: Colors.blueAccent.withAlpha(128),
        onTap: _tap,
      ),
    );
  }

  _tap() {
    AppRouter.navigator.pushNamed("/view", arguments: galleryItem);
  }
}
