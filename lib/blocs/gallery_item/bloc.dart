import 'package:epicture/blocs/gallery_item/event.dart';
import 'package:epicture/blocs/gallery_item/state.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/repositories/gallery_item.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryItemBloc extends Bloc<GalleryItemEvent, GalleryItemState> {
  final GalleryItemRepository _repository;

  static GalleryItemBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  GalleryItemBloc(this._repository) : super(GalleryItemInitialState());

  @override
  Stream<GalleryItemState> mapEventToState(GalleryItemEvent event) async* {
    yield GalleryItemLoadingState();

    if (event is GalleryItemGetEvent) {
      yield* _get(event);
    } else if (event is GalleryItemRemoveEvent) {
      yield* _remove(event);
    } else if (event is GalleryItemShareEvent) {
      yield* _share(event);
    } else if (event is GalleryItemVoteEvent) {
      yield* _vote(event);
    }
  }

  Stream<GalleryItemState> _get(GalleryItemGetEvent event) async* {
    try {
      final GalleryItemModel galleryItem = await _repository.get(
        type: event.type,
        id: event.id,
      );

      yield GalleryItemGotState(galleryItem: galleryItem);
    } on Exception catch (e) {
      yield GalleryItemErrorState(message: e.toString());
    }
  }

  Stream<GalleryItemState> _remove(GalleryItemRemoveEvent event) async* {
    try {
      final GalleryItemModel galleryItem = await _repository.remove(
        id: event.id,
        token: event.token,
      );

      yield GalleryItemGotState(galleryItem: galleryItem);
    } on Exception catch (e) {
      yield GalleryItemErrorState(message: e.toString());
    }
  }

  Stream<GalleryItemState> _share(GalleryItemShareEvent event) async* {
    try {
      final GalleryItemModel galleryItem = await _repository.share(
        type: event.type,
        id: event.id,
        token: event.token,
        title: event.title,
        topic: event.topic,
        tags: event.tags,
      );

      yield GalleryItemGotState(galleryItem: galleryItem);
    } on Exception catch (e) {
      yield GalleryItemErrorState(message: e.toString());
    }
  }

  Stream<GalleryItemState> _vote(GalleryItemVoteEvent event) async* {
    try {
      final GalleryItemModel galleryItem = await _repository.vote(
        id: event.id,
        vote: event.vote,
        token: event.token,
      );

      yield GalleryItemGotState(galleryItem: galleryItem);
    } on Exception catch (e) {
      yield GalleryItemErrorState(message: e.toString());
    }
  }
}
