import 'package:epicture/blocs/common/event.dart';

abstract class GalleryTagsEvent extends Event {
  const GalleryTagsEvent();
}

class GalleryTagsGetEvent extends GalleryTagsEvent {
  final String token;

  const GalleryTagsGetEvent({this.token});
}
