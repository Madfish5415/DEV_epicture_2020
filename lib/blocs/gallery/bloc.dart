import 'package:epicture/blocs/gallery/event.dart';
import 'package:epicture/blocs/gallery/state.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/repositories/gallery.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GalleryRepository _repository;

  static GalleryBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  GalleryBloc(this._repository) : super(GalleryInitialState());

  @override
  Stream<GalleryState> mapEventToState(GalleryEvent event) async* {
    yield GalleryLoadingState();

    if (event is GalleryGetEvent) {
      yield* _get(event);
    } else if (event is GalleryGetByTagEvent) {
      yield* _getByTag(event);
    } else if (event is GallerySearchEvent) {
      yield* _search(event);
    }
  }

  Stream<GalleryState> _get(GalleryGetEvent event) async* {
    try {
      final List<GalleryItemModel> gallery = await _repository.get(
        section: event.section,
        sort: event.sort,
        window: event.window,
        page: event.page,
        token: event.token,
      );

      yield GalleryGotState(gallery: gallery);
    } on Exception catch (e) {
      yield GalleryErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }

  Stream<GalleryState> _getByTag(GalleryGetByTagEvent event) async* {
    try {
      final List<GalleryItemModel> gallery = await _repository.getByTag(
        tag: event.tag,
        sort: event.sort,
        window: event.window,
        page: event.page,
        token: event.token,
      );

      yield GalleryGotState(gallery: gallery);
    } on Exception catch (e) {
      yield GalleryErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }

  Stream<GalleryState> _search(GallerySearchEvent event) async* {
    try {
      final List<GalleryItemModel> gallery = await _repository.search(
        query: event.query,
        sort: event.sort,
        window: event.window,
        page: event.page,
        token: event.token,
      );

      yield GalleryGotState(gallery: gallery);
    } on Exception catch (e) {
      yield GalleryErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }
}
