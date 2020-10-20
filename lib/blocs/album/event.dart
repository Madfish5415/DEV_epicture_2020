import 'package:flutter/foundation.dart';

abstract class AlbumEvent {
  const AlbumEvent();
}

class AlbumGetEvent extends AlbumEvent {
  final String id;
  final String token;

  const AlbumGetEvent({
    @required this.id,
    this.token,
  });
}
