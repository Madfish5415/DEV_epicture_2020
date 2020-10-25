import 'package:epicture/blocs/common/state.dart';
import 'package:epicture/blocs/gallery_tags.dart';
import 'package:epicture/models/gallery_tag.dart';
import 'package:flutter/foundation.dart';

abstract class GalleryTagsState {
  const GalleryTagsState();
}

class GalleryTagsInitialState extends GalleryTagsState {
  const GalleryTagsInitialState();
}

class GalleryTagsLoadingState extends GalleryTagsState {
  const GalleryTagsLoadingState();
}

class GalleryTagsGotState extends GalleryTagsState {
  final List<GalleryTagModel> galleryTags;

  const GalleryTagsGotState({@required this.galleryTags});
}

class GalleryTagsErrorState extends GalleryTagsState implements ErrorState {
  final GalleryTagsEvent event;
  final String message;

  const GalleryTagsErrorState({
    @required this.event,
    this.message,
  });
}
