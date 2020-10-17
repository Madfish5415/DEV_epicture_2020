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
  final GalleryItemModel galleryItem;

  const GalleryItemVotedState({@required this.galleryItem});
}

class GalleryItemErrorState extends GalleryItemState {
  final String message;

  const GalleryItemErrorState({this.message});
}
