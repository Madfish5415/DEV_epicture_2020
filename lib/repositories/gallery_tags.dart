import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/gallery_tag.dart';

class GalleryTagsRepository {
  Future<List<GalleryTagModel>> get({
    String token,
  }) async {
    final response = await ImgurClient.get(
      endpoint: "/3/tags",
      token: token,
    );
    final List<dynamic> jsonItemList = response["data"]["tags"];
    final List<GalleryTagModel> galleryTags = jsonItemList
        .map((jsonItem) => GalleryTagModel.fromJson(jsonItem))
        .toList();

    return galleryTags;
  }
}
