import 'package:epicture/blocs/gallery_item.dart';
import 'package:epicture/error/page.dart';
import 'package:epicture/models/album.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/repositories/gallery_item.dart';
import 'package:epicture/widgets/gallery_item/gallery_item_edit_action.dart';
import 'package:epicture/widgets/gallery_item/gallery_item_favorite_action.dart';
import 'package:epicture/widgets/gallery_item/gallery_item_information.dart';
import 'package:epicture/widgets/gallery_item/gallery_item_view.dart';
import 'package:epicture/widgets/gallery_item/gallery_item_vote_actions.dart';
import 'package:epicture/widgets/user/user_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GalleryItemModel galleryItem =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Builder(
        builder: (context) {
          if (!galleryItem.public) {
            return _ViewImage(galleryItem: galleryItem);
          }

          return _ViewGalleryItem(galleryItem: galleryItem);
        },
      ),
    );
  }
}

class _ViewGalleryItem extends StatelessWidget {
  const _ViewGalleryItem({
    @required this.galleryItem,
  });

  final GalleryItemModel galleryItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GalleryItemBloc(GalleryItemRepository())
          ..add(
            GalleryItemGetEvent(
              type: (galleryItem.child is AlbumModel) ? "album" : "image",
              id: galleryItem.child.id,
            ),
          );
      },
      child: BlocBuilder<GalleryItemBloc, GalleryItemState>(
        builder: (context, state) {
          if (state is GalleryItemGotState) {
            return _ViewGalleryItemGot(galleryItem: state.galleryItem);
          } else if (state is GalleryItemErrorState) {
            return _ViewGalleryItemError(error: state);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _ViewGalleryItemGot extends StatelessWidget {
  final GalleryItemModel galleryItem;

  _ViewGalleryItemGot({
    @required this.galleryItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: GalleryItemViewWidget(galleryItem: galleryItem)),
        GalleryItemInformationWidget(galleryItem: galleryItem),
        UserShowWidget(
          builder: (context, user) {
            return Row(
              children: [
                GalleryItemFavoriteActionWidget(
                  galleryItem: galleryItem,
                  user: user,
                ),
                GalleryItemVoteActionsWidget(
                  galleryItem: galleryItem,
                  user: user,
                ),
                GalleryItemEditActionWidget(
                  galleryItem: galleryItem,
                  user: user,
                )
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ViewGalleryItemError extends StatelessWidget {
  final GalleryItemErrorState error;

  _ViewGalleryItemError({
    @required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return PageErrorWidget(
      error: error,
      onPressed: () {
        GalleryItemBloc.of(context).add(error.event);
      },
    );
  }
}

class _ViewImage extends StatelessWidget {
  final GalleryItemModel galleryItem;

  _ViewImage({
    @required this.galleryItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: GalleryItemViewWidget(galleryItem: galleryItem)),
        GalleryItemInformationWidget(galleryItem: galleryItem),
        UserShowWidget(builder: (context, user) {
          return Row(
            children: [
              GalleryItemEditActionWidget(
                galleryItem: galleryItem,
                user: user,
              )
            ],
          );
        }),
      ],
    );
  }
}
