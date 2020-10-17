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

    if (event is AlbumGetEvent) {
      yield* _get(event);
    }
  }

  Stream<AlbumState> _get(AlbumGetEvent event) async* {
    try {
      final AlbumModel album = await _repository.get(id: event.id);

      yield AlbumGotState(album: album);
    } on Exception catch (e) {
      yield AlbumErrorState(message: e.toString());
    }
  }
}
