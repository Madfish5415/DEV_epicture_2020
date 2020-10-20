import 'package:epicture/blocs/gallery_item.dart';
import 'package:epicture/models/album.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/repositories/gallery_item.dart';
import 'package:epicture/widgets/model/gallery_item_favorite_action.dart';
import 'package:epicture/widgets/model/gallery_item_vote_actions.dart';
import 'package:epicture/widgets/model/gallery_item_information.dart';
import 'package:epicture/widgets/model/gallery_item_user_show.dart';
import 'package:epicture/widgets/model/gallery_item_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GalleryItemModel galleryItem =
        ModalRoute
            .of(context)
            .settings
            .arguments;

    return BlocProvider(
      create: (_) =>
      GalleryItemBloc(GalleryItemRepository())
        ..add(GalleryItemGetEvent(
          type: (galleryItem.child is AlbumModel) ? "album" : "image",
          id: galleryItem.child.id,
        )),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: BlocBuilder<GalleryItemBloc, GalleryItemState>(
          builder: (context, state) {
            if (state is GalleryItemGotState) {
              return _ViewGalleryItemGotWidget(galleryItem: galleryItem);
            } else if (state is GalleryItemErrorState) {
              return _ViewGalleryItemErrorWidget(error: state);
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _ViewGalleryItemGotWidget extends StatelessWidget {
  final GalleryItemModel galleryItem;

  _ViewGalleryItemGotWidget({
    @required this.galleryItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: GalleryItemViewWidget(galleryItem: galleryItem)),
        GalleryItemInformationWidget(galleryItem: galleryItem),
        GalleryItemUserShowWidget(
          galleryItem: galleryItem,
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
              ],
            );
          },
        )
      ],
    );
  }
}

class _ViewGalleryItemErrorWidget extends StatelessWidget {
  final GalleryItemErrorState error;

  _ViewGalleryItemErrorWidget({
    @required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error.message),
          TextButton(
            onPressed: () {
              GalleryItemBloc.of(context).add(error.event);
            },
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }
}
