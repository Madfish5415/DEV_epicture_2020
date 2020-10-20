abstract class GalleryTagsEvent {
  const GalleryTagsEvent();
}

class GalleryTagsGetEvent extends GalleryTagsEvent {
  final String token;

  const GalleryTagsGetEvent({this.token});
}
