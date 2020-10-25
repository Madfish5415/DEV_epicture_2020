import 'package:epicture/blocs/album/event.dart';
import 'package:epicture/blocs/album/state.dart';
import 'package:epicture/models/album.dart';
import 'package:epicture/repositories/album.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumRepository _repository;

  static AlbumBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  AlbumBloc(this._repository) : super(AlbumInitialState());

  @override
  Stream<AlbumState> mapEventToState(AlbumEvent event) async* {
    yield AlbumLoadingState();

    if (event is AlbumFavoriteEvent) {
      yield* _favorite(event);
    } else if (event is AlbumGetEvent) {
      yield* _get(event);
    }
  }

  Stream<AlbumState> _favorite(AlbumFavoriteEvent event) async* {
    try {
      final bool favorited = await _repository.favorite(
        id: event.id,
        token: event.token,
      );

      yield AlbumFavoritedState(id: event.id, favorited: favorited);
    } on Exception catch (e) {
      yield AlbumErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }

  Stream<AlbumState> _get(AlbumGetEvent event) async* {
    try {
      final AlbumModel album = await _repository.get(
        id: event.id,
        token: event.token,
      );

      yield AlbumGotState(album: album);
    } on Exception catch (e) {
      yield AlbumErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }
}
