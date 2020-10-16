import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/gallery.dart';
import 'package:epicture/models/gallery_tag.dart';

class GalleryRepository {
  Future<List<GalleryModel>> get({
    String section = "hot",
    String sort = "viral",
    String window = "day",
    int page = 0,
  }) async {
    final response = await ImgurClient.get(
      "/3/gallery/$section/$sort/$window/$page",
    );
    final List<Map<String, dynamic>> jsonItemList = response["data"];
    final List<GalleryModel> gallery = jsonItemList
        .map((jsonItem) => GalleryModel.fromJson(jsonItem))
        .toList();

    return gallery;
  }

  Future<List<GalleryModel>> getByTag(
    String tag, {
    String sort = "viral",
    String window = "day",
    int page = 0,
  }) async {
    final response = await ImgurClient.get(
      "/3/gallery/t/$tag/$sort/$window/$page",
    );
    final List<Map<String, dynamic>> jsonItemList = response["data"];
    final List<GalleryModel> gallery = jsonItemList
        .map((jsonItem) => GalleryModel.fromJson(jsonItem))
        .toList();

    return gallery;
  }

  Future<GalleryModel> remove(
      int id,
      String vote,
      ) async {
    final response = await ImgurClient.delete(
      "/3/gallery/$id",
    );

    return GalleryModel.fromJson(response["data"]);
  }

  Future<List<GalleryModel>> search(
    String q, {
    String sort = "viral",
    String window = "day",
    int page = 0,
  }) async {
    final response = await ImgurClient.get(
      "/3/gallery/t/search/$sort/$window/$page",
      queryParameters: {
        "q": q,
      },
    );
    final List<Map<String, dynamic>> jsonItemList = response["data"];
    final List<GalleryModel> gallery = jsonItemList
        .map((jsonItem) => GalleryModel.fromJson(jsonItem))
        .toList();

    return gallery;
  }

  Future<GalleryModel> shareImage(
    String id,
    String title, {
    String topic,
    List<String> tags,
  }) async {
    final response = await ImgurClient.post(
      "/3/gallery/image/$id",
      queryParameters: {
        "title": title,
        "topic": topic,
        "tags": tags,
        "terms": 1,
      },
    );

    return GalleryModel.fromJson(response["data"]);
  }

  Future<List<GalleryTagModel>> tags() async {
    final response = await ImgurClient.get(
      "/3/tags",
    );
    final List<Map<String, dynamic>> jsonItemList = response["data"];
    final List<GalleryTagModel> galleryTags = jsonItemList
        .map((jsonItem) => GalleryTagModel.fromJson(jsonItem))
        .toList();

    return galleryTags;
  }

  Future<GalleryModel> vote(
    int id,
    String vote,
  ) async {
    final response = await ImgurClient.post(
      "/3/gallery/$id/vote/$vote",
    );

    return GalleryModel.fromJson(response["data"]);
  }
}
