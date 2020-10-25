import 'package:epicture/blocs/gallery_tags/event.dart';
import 'package:epicture/blocs/gallery_tags/state.dart';
import 'package:epicture/models/gallery_tag.dart';
import 'package:epicture/repositories/gallery_tags.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryTagsBloc extends Bloc<GalleryTagsEvent, GalleryTagsState> {
  final GalleryTagsRepository _repository;

  static GalleryTagsBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  GalleryTagsBloc(this._repository) : super(GalleryTagsInitialState());

  @override
  Stream<GalleryTagsState> mapEventToState(GalleryTagsEvent event) async* {
    yield GalleryTagsLoadingState();

    if (event is GalleryTagsGetEvent) {
      yield* _get(event);
    }
  }

  Stream<GalleryTagsState> _get(GalleryTagsGetEvent event) async* {
    try {
      final List<GalleryTagModel> galleryTags = await _repository.get(
        token: event.token,
      );

      yield GalleryTagsGotState(galleryTags: galleryTags);
    } on Exception catch (e) {
      yield GalleryTagsErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }
}
