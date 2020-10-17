import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/gallery_tag.dart';

class GalleryTagsRepository {
  Future<List<GalleryTagModel>> get() async {
    final response = await ImgurClient.get(
      endpoint: "/3/tags",
    );
    final List<Map<String, dynamic>> jsonItemList = response["data"];
    final List<GalleryTagModel> galleryTags = jsonItemList
        .map((jsonItem) => GalleryTagModel.fromJson(jsonItem))
        .toList();

    return galleryTags;
  }
}
