import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/widgets/icon/icon_text.dart';
import 'package:flutter/material.dart';

class GalleryItemInformationWidget extends StatelessWidget {
  final GalleryItemModel galleryItem;

  GalleryItemInformationWidget({
    @required this.galleryItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            galleryItem.child.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            galleryItem.child.description ?? "No description",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Row(
            children: [
              IconTextWidget(
                icon: Icon(Icons.favorite_border),
                text: Text(galleryItem.favorites.toString(),
                    style: TextStyle(fontSize: 16)),
              ),
              IconTextWidget(
                icon: Icon(Icons.arrow_upward),
                text: Text(galleryItem.ups.toString(),
                    style: TextStyle(fontSize: 16)),
              ),
              IconTextWidget(
                icon: Icon(Icons.arrow_downward),
                text: Text(galleryItem.downs.toString(),
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
