import 'package:flutter/foundation.dart';

abstract class GalleryEvent {
  const GalleryEvent();
}

class GalleryGetEvent extends GalleryEvent {
  final String section;
  final String sort;
  final String window;
  final int page;
  final String token;

  const GalleryGetEvent({
    this.section = "hot",
    this.sort = "viral",
    this.window = "day",
    this.page = 0,
    this.token,
  });
}

class GalleryGetByTagEvent extends GalleryEvent {
  final String tag;
  final String sort;
  final String window;
  final int page;
  final String token;

  const GalleryGetByTagEvent({
    @required this.tag,
    this.sort = "viral",
    this.window = "day",
    this.page = 0,
    this.token,
  });
}

class GallerySearchEvent extends GalleryEvent {
  final String query;
  final String sort;
  final String window;
  final int page;
  final String token;

  const GallerySearchEvent({
    @required this.query,
    this.sort = "viral",
    this.window = "day",
    this.page = 0,
    this.token,
  });
}
