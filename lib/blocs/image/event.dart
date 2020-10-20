import 'package:flutter/foundation.dart';

abstract class ImageEvent {
  const ImageEvent();
}

class ImageDeleteEvent extends ImageEvent {
  final String id;
  final String token;

  const ImageDeleteEvent({
    @required this.id,
    @required this.token,
  });
}

class ImageFavoriteEvent extends ImageEvent {
  final String id;
  final String token;

  const ImageFavoriteEvent({
    @required this.id,
    @required this.token,
  });
}

class ImageGetEvent extends ImageEvent {
  final String id;
  final String token;

  const ImageGetEvent({
    @required this.id,
    this.token,
  });
}

class ImageUpdateEvent extends ImageEvent {
  final String id;
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