import 'package:epicture/models/album.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/router.dart';
import 'package:epicture/widgets/album/album_preview.dart';
import 'package:epicture/widgets/icon/icon_text.dart';
import 'package:epicture/widgets/image/image_preview.dart';
import 'package:epicture/widgets/ink/ink_well.dart';
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
          _GalleryItemCardBody(galleryItem: galleryItem),
          InkWellWidget(
            onTap: () {
              AppRouter.navigator.pushNamed("/view", arguments: galleryItem);
            },
          ),
        ],
      ),
    );
  }
}

class _GalleryItemCardBody extends StatelessWidget {
  const _GalleryItemCardBody({
    @required this.galleryItem,
  });

  final GalleryItemModel galleryItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1 / 1,
          child: _GalleryItemCardBodyImage(child: galleryItem.child),
        ),
        Expanded(
          child: _GalleryItemCardBodyBottom(galleryItem: galleryItem),
        ),
      ],
    );
  }
}

class _GalleryItemCardBodyImage extends StatelessWidget {
  final dynamic child;

  _GalleryItemCardBodyImage({
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

class _GalleryItemCardBodyBottom extends StatelessWidget {
  final GalleryItemModel galleryItem;

  _GalleryItemCardBodyBottom({
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
