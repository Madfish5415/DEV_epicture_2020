import 'package:epicture/blocs/image/event.dart';
import 'package:epicture/blocs/image/state.dart';
import 'package:epicture/models/image.dart';
import 'package:epicture/repositories/image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageRepository _repository;

  static ImageBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  ImageBloc(this._repository) : super(ImageInitialState());

  @override
  Stream<ImageState> mapEventToState(ImageEvent event) async* {
    yield ImageLoadingState();

    if (event is ImageDeleteEvent) {
      yield* _delete(event);
    } else if (event is ImageFavoriteEvent) {
      yield* _favorite(event);
    } else if (event is ImageGetEvent) {
      yield* _get(event);
    } else if (event is ImageUpdateEvent) {
      yield* _update(event);
    } else if (event is ImageUploadEvent) {
      yield* _upload(event);
    }
  }

  Stream<ImageState> _delete(ImageDeleteEvent event) async* {
    try {
      final bool deleted = await _repository.delete(
        id: event.id,
        token: event.token,
      );

      yield ImageDeletedState(id: event.id, deleted: deleted);
    } on Exception catch (e) {
      yield ImageErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }

  Stream<ImageState> _favorite(ImageFavoriteEvent event) async* {
    try {
      final bool favorited = await _repository.favorite(
        id: event.id,
        token: event.token,
      );

      yield ImageFavoritedState(id: event.id, favorited: favorited);
    } on Exception catch (e) {
      yield ImageErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }

  Stream<ImageState> _get(ImageGetEvent event) async* {
    try {
      final ImageModel image = await _repository.get(
        id: event.id,
        token: event.token,
      );

      yield ImageGotState(image: image);
    } on Exception catch (e) {
      yield ImageErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }

  Stream<ImageState> _update(ImageUpdateEvent event) async* {
    try {
      final bool updated = await _repository.update(
        id: event.id,
        token: event.token,
        title: event.title,
        description: event.description,
      );

      print("update success");

      yield ImageUpdatedState(id: event.id, updated: updated);
    } on Exception catch (e) {
      yield ImageErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }

  Stream<ImageState> _upload(ImageUploadEvent event) async* {
    try {
      final ImageModel image = await _repository.upload(
        token: event.token,
        field: event.field,
        file: event.file,
        title: event.title,
        description: event.description,
      );

      yield ImageUploadedState(image: image);
    } on Exception catch (e) {
      yield ImageErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }
}
