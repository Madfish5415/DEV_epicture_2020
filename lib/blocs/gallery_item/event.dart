import 'package:epicture/blocs/common/event.dart';
import 'package:flutter/foundation.dart';

abstract class GalleryItemEvent extends Event {
  const GalleryItemEvent();
}

class GalleryItemFavoriteEvent extends GalleryItemEvent {
  final String type;
  final String id;
  final String token;

  const GalleryItemFavoriteEvent({
    @required this.type,
    @required this.id,
    this.token,
  });
}

class GalleryItemGetEvent extends GalleryItemEvent {
  final String type;
  final String id;
  final String token;

  const GalleryItemGetEvent({
    @required this.type,
    @required this.id,
    this.token,
  });
}

class GalleryItemRemoveEvent extends GalleryItemEvent {
  final String id;
  final String token;

  const GalleryItemRemoveEvent({
    @required this.id,
    @required this.token,
  });
}

class GalleryItemShareEvent extends GalleryItemEvent {
  final String type;
  final String id;
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
  final String id;
  final String vote;
  final String token;

  const GalleryItemVoteEvent({
    @required this.id,
    @required this.vote,
    @required this.token,
  });
}
