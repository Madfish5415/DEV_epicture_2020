import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/models/image.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/router.dart';
import 'package:flutter/material.dart';

class GalleryItemEditActionWidget extends StatelessWidget {
  final GalleryItemModel galleryItem;
  final UserModel user;

  GalleryItemEditActionWidget({
    @required this.galleryItem,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (galleryItem.child.authorId.toString() == user.accountId) {
          return _GalleryItemEditButton(
            image: galleryItem.child,
            user: user,
          );
        }

        return Container();
      },
    );
  }
}

class _GalleryItemEditButton extends StatelessWidget {
  final ImageModel image;
  final UserModel user;

  _GalleryItemEditButton({
    @required this.image,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      color: Colors.black,
      onPressed: () {
        AppRouter.navigator.pushReplacementNamed(
          "/edit",
          arguments: {
            "image": image,
            "user": user,
          },
        );
      },
    );
  }
}
