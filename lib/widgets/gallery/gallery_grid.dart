import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/widgets/gallery_item/gallery_item_card.dart';
import 'package:flutter/material.dart';

class GalleryGridWidget extends StatelessWidget {
  final List<GalleryItemModel> gallery;

  GalleryGridWidget({
    @required this.gallery,
  });

  @override
  Widget build(BuildContext context) {
    if (gallery.isEmpty) {
      return Center(
        child: Text("No item found"),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 8 / 10,
      ),
      itemCount: gallery.length,
      itemBuilder: (context, index) {
        return GalleryItemCard(
          galleryItem: gallery[index],
        );
      },
    );
  }
}
