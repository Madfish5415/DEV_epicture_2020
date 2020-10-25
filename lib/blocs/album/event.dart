import 'package:epicture/blocs/common/event.dart';
import 'package:flutter/foundation.dart';

abstract class AlbumEvent extends Event {
  const AlbumEvent();
}

class AlbumFavoriteEvent extends AlbumEvent {
  final String id;
  final String token;

  const AlbumFavoriteEvent({
    @required this.id,
    this.token,
  });
}

class AlbumGetEvent extends AlbumEvent {
  final String id;
  final String token;

  const AlbumGetEvent({
    @required this.id,
    this.token,
  });
}
