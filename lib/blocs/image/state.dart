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
  final ImageModel image;

  const ImageDeletedState({@required this.image});
}

class ImageFavoritedState extends ImageState {
  final ImageModel image;

  const ImageFavoritedState({@required this.image});
}

class ImageGotState extends ImageState {
  final ImageModel image;

  const ImageGotState({@required this.image});
}

class ImageUpdatedState extends ImageState {
  final ImageModel image;

  const ImageUpdatedState({@required this.image});
}

class ImageErrorState extends ImageState {
  final String message;

  const ImageErrorState({this.message});
}
