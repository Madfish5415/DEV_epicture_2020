import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:flutter/foundation.dart';

class GalleryRepository {
  Future<List<GalleryItemModel>> get({
    String section = "hot",
    String sort = "viral",
    String window = "day",
    int page = 0,
  }) async {
    final response = await ImgurClient.get(
      endpoint: "/3/gallery/$section/$sort/$window/$page",
    );
    final List<Map<String, dynamic>> jsonItemList = response["data"];
    final List<GalleryItemModel> gallery = jsonItemList
        .map((jsonItem) => GalleryItemModel.fromJson(jsonItem))
        .toList();

    return gallery;
  }

  Future<List<GalleryItemModel>> getByTag({
    @required String tag,
    String sort = "viral",
    String window = "day",
    int page = 0,
  }) async {
    final response = await ImgurClient.get(
      endpoint: "/3/gallery/t/$tag/$sort/$window/$page",
    );
    final List<Map<String, dynamic>> jsonItemList = response["data"];
    final List<GalleryItemModel> gallery = jsonItemList
        .map((jsonItem) => GalleryItemModel.fromJson(jsonItem))
        .toList();

    return gallery;
  }

  Future<List<GalleryItemModel>> search({
    @required String query,
    String sort = "viral",
    String window = "day",
    int page = 0,
  }) async {
    final response = await ImgurClient.get(
      endpoint: "/3/gallery/t/search/$sort/$window/$page",
      queryParameters: {
        "q": query,
      },
    );
    final List<Map<String, dynamic>> jsonItemList = response["data"];
    final List<GalleryItemModel> gallery = jsonItemList
        .map((jsonItem) => GalleryItemModel.fromJson(jsonItem))
        .toList();

    return gallery;
  }
}
