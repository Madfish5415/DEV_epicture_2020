import 'package:epicture/blocs/gallery_item.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/repositories/gallery_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryItemFavoriteActionWidget extends StatelessWidget {
  final GalleryItemModel galleryItem;
  final UserModel user;

  GalleryItemFavoriteActionWidget({
    @required this.galleryItem,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GalleryItemBloc(GalleryItemRepository())
          ..add(GalleryItemGetEvent(
            type: galleryItem.type,
            id: galleryItem.child.id,
            token: user.accessToken,
          ));
      },
      child: BlocBuilder<GalleryItemBloc, GalleryItemState>(
        builder: (context, state) {
          bool favorited = false;

          if (state is GalleryItemGotState) {
            favorited = state.galleryItem.child.favorite;
          } else if (state is GalleryItemFavoritedState) {
            favorited = state.favorited;
          }

          return _GalleryItemFavoriteButton(
            type: galleryItem.type,
            id: galleryItem.child.id,
            token: user.accessToken,
            state: favorited,
          );
        },
      ),
    );
  }
}

class _GalleryItemFavoriteButton extends StatelessWidget {
  final String type;
  final String id;
  final String token;
  final bool state;

  _GalleryItemFavoriteButton({
    @required this.type,
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
        GalleryItemBloc.of(context).add(
          GalleryItemFavoriteEvent(
            type: type,
            id: id,
            token: token,
          ),
        );
      },
    );
  }
}
