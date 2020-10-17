import 'package:flutter/foundation.dart';

abstract class AlbumEvent {
  const AlbumEvent();
}

class AlbumGetEvent extends AlbumEvent {
  final int id;

  const AlbumGetEvent({@required this.id});
}
