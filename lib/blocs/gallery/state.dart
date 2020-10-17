import 'package:epicture/models/gallery_item.dart';
import 'package:flutter/foundation.dart';

abstract class GalleryState {
  const GalleryState();
}

class GalleryInitialState extends GalleryState {
  const GalleryInitialState();
}

class GalleryLoadingState extends GalleryState {
  const GalleryLoadingState();
}

class GalleryGotState extends GalleryState {
  final List<GalleryItemModel> gallery;

  const GalleryGotState({@required this.gallery});
}

class GalleryErrorState extends GalleryState {
  final String message;

  const GalleryErrorState({this.message});
}
