import 'package:epicture/blocs/image.dart';
import 'package:epicture/models/album.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/models/image.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/repositories/image.dart';
import 'package:epicture/widgets/model/image_view.dart';
import 'package:epicture/widgets/model/user_show.dart';
import 'package:epicture/widgets/model/video_view.dart';
import 'package:epicture/widgets/utility/icon_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                UserShowWidget(
                  builder: (context, user) {
                    return _GalleryItemFavoriteAction(image: image, user: user);
                  },
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

class _GalleryItemFavoriteAction extends StatelessWidget {
  final ImageModel image;
  final UserModel user;

  _GalleryItemFavoriteAction({
    @required this.image,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ImageBloc(ImageRepository())
          ..add(ImageGetEvent(
            id: image.id,
            token: user.accessToken,
          ));
      },
      child: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          bool favorited = false;

          if (state is ImageGotState) {
            favorited = state.image.favorite;
          } else if (state is ImageFavoritedState) {
            favorited = state.favorited;
          }

          return _GalleryItemFavoriteButton(
            id: image.id,
            token: user.accessToken,
            state: favorited,
          );
        },
      ),
    );
  }
}

class _GalleryItemFavoriteButton extends StatelessWidget {
  final String id;
  final String token;
  final bool state;

  _GalleryItemFavoriteButton({
    @required this.id,
    @required this.token,
    @required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon((!state) ? Icons.favorite_border : Icons.favorite),
      color: (!state) ? Colors.black : Colors.red,
      onPressed: () {
        ImageBloc.of(context).add(
          ImageFavoriteEvent(
            id: id,
            token: token,
          ),
        );
      },
    );
  }
}
