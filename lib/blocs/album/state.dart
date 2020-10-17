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

class AlbumGotState extends AlbumState {
  final AlbumModel album;

  const AlbumGotState({@required this.album});
}

class AlbumErrorState extends AlbumState {
  final String message;

  const AlbumErrorState({this.message});
}
