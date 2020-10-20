import 'package:epicture/blocs/gallery_item/event.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:flutter/foundation.dart';

abstract class GalleryItemState {
  const GalleryItemState();
}

class GalleryItemInitialState extends GalleryItemState {
  const GalleryItemInitialState();
}

class GalleryItemLoadingState extends GalleryItemState {
  const GalleryItemLoadingState();
}

class GalleryItemFavoritedState extends GalleryItemState {
  final String id;
  final bool favorited;

  const GalleryItemFavoritedState({
    @required this.id,
    @required this.favorited,
  });
}

class GalleryItemGotState extends GalleryItemState {
  final GalleryItemModel galleryItem;

  const GalleryItemGotState({@required this.galleryItem});
}

class GalleryItemRemovedState extends GalleryItemState {
  final GalleryItemModel galleryItem;

  const GalleryItemRemovedState({@required this.galleryItem});
}

class GalleryItemSharedState extends GalleryItemState {
  final GalleryItemModel galleryItem;

  const GalleryItemSharedState({@required this.galleryItem});
}

class GalleryItemVotedState extends GalleryItemState {
  final String id;
  final String vote;
  final bool voted;

  const GalleryItemVotedState({
    @required this.id,
    @required this.vote,
    @required this.voted,
  });
}

class GalleryItemErrorState extends GalleryItemState {
  final GalleryItemEvent event;
  final String message;

  const GalleryItemErrorState({
    @required this.event,
    this.message,
  });
}
