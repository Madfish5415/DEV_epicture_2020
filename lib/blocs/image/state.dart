import 'package:epicture/blocs/image.dart';
import 'package:epicture/models/image.dart';
import 'package:flutter/foundation.dart';

abstract class ImageState {
  const ImageState();
}

class ImageInitialState extends ImageState {
  const ImageInitialState();
}

class ImageLoadingState extends ImageState {
  const ImageLoadingState();
}

class ImageDeletedState extends ImageState {
  final String id;
  final bool deleted;

  const ImageDeletedState({
    @required this.id,
    @required this.deleted,
  });
}

class ImageFavoritedState extends ImageState {
  final String id;
  final bool favorited;

  const ImageFavoritedState({
    @required this.id,
    @required this.favorited,
  });
}

class ImageGotState extends ImageState {
  final ImageModel image;

  const ImageGotState({@required this.image});
}

class ImageUpdatedState extends ImageState {
  final String id;
  final bool updated;

  const ImageUpdatedState({
    @required this.id,
    @required this.updated,
  });
}

class ImageUploadedState extends ImageState {
  final ImageModel image;

  const ImageUploadedState({@required this.image});
}

class ImageErrorState extends ImageState {
  final ImageEvent event;
  final String message;

  const ImageErrorState({
    @required this.event,
    this.message,
  });
}
