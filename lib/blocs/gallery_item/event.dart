import 'package:flutter/foundation.dart';

abstract class GalleryItemEvent {
  const GalleryItemEvent();
}

class GalleryItemGetEvent extends GalleryItemEvent {
  final String type;
  final int id;

  const GalleryItemGetEvent({
    @required this.type,
    @required this.id,
  });
}

class GalleryItemRemoveEvent extends GalleryItemEvent {
  final int id;
  final String token;

  const GalleryItemRemoveEvent({
    @required this.id,
    @required this.token,
  });
}

class GalleryItemShareEvent extends GalleryItemEvent {
  final String type;
  final int id;
  final String token;
  final String title;
  final String topic;
  final List<String> tags;

  const GalleryItemShareEvent({
    @required this.type,
    @required this.id,
    @required this.token,
    @required this.title,
    this.topic,
    this.tags,
  });
}

class GalleryItemVoteEvent extends GalleryItemEvent {
  final int id;
  final String vote;
  final String token;

  const GalleryItemVoteEvent({
    @required this.id,
    @required this.vote,
    @required this.token,
  });
}
