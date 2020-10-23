import 'package:epicture/blocs/album.dart';
import 'package:epicture/blocs/common/state.dart';
import 'package:epicture/models/album.dart';
import 'package:flutter/foundation.dart';

abstract class AlbumState {
  const AlbumState();
}

class AlbumInitialState extends AlbumState {
  const AlbumInitialState();
}

class AlbumLoadingState extends AlbumState {
  const AlbumLoadingState();
}

class AlbumFavoritedState extends AlbumState {
  final String id;
  final bool favorited;

  const AlbumFavoritedState({
    @required this.id,
    @required this.favorited,
  });
}

class AlbumGotState extends AlbumState {
  final AlbumModel album;

  const AlbumGotState({@required this.album});
}

class AlbumErrorState extends AlbumState implements ErrorState {
  final AlbumEvent event;
  final String message;

  const AlbumErrorState({
    @required this.event,
    this.message,
  });
}
