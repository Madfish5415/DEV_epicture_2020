import 'package:epicture/models/gallery_tag.dart';
import 'package:epicture/widgets/gallery_tag/gallery_tag_card.dart';
import 'package:flutter/material.dart';

class GalleryTagsGridWidget extends StatelessWidget {
  final List<GalleryTagModel> galleryTags;

  GalleryTagsGridWidget({
    @required this.galleryTags,
  });

  @override
  Widget build(BuildContext context) {
    if (galleryTags.isEmpty) {
      return Center(
        child: Text("No item found"),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 8 / 10,
      ),
      itemCount: galleryTags.length,
      itemBuilder: (context, index) {
        return GalleryTagCard(
          galleryTag: galleryTags[index],
        );
      },
    );
  }
}
