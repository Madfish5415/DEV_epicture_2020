import 'package:flutter/foundation.dart';

abstract class ImageEvent {
  const ImageEvent();
}

class ImageDeleteEvent extends ImageEvent {
  final int id;
  final String token;

  const ImageDeleteEvent({
    @required this.id,
    @required this.token,
  });
}

class ImageFavoriteEvent extends ImageEvent {
  final int id;
  final String token;

  const ImageFavoriteEvent({
    @required this.id,
    @required this.token,
  });
}

class ImageGetEvent extends ImageEvent {
  final int id;

  const ImageGetEvent({@required this.id});
}

class ImageUpdateEvent extends ImageEvent {
  final int id;
  final String token;
  final String title;
  final String description;

  const ImageUpdateEvent({
    @required this.id,
    @required this.token,
    this.title,
    this.description,
  });
}
