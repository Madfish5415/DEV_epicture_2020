import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:flutter/foundation.dart';

class GalleryItemRepository {
  Future<bool> favorite({
    @required String type,
    @required String id,
    String token,
  }) async {
    final response = await ImgurClient.post(
      endpoint: "/3/$type/$id/favorite",
      token: token,
    );
    final bool favorited = (response["data"] == "favorited");

    return favorited;
  }

  Future<GalleryItemModel> get({
    @required String type,
    @required String id,
    String token,
  }) async {
    final response = await ImgurClient.get(
      endpoint: "/3/gallery/$type/$id",
      token: token,
    );

    return GalleryItemModel.fromJson(response["data"]);
  }

  Future<GalleryItemModel> remove({
    @required String id,
    @required String token,
  }) async {
    final response = await ImgurClient.delete(
      endpoint: "/3/gallery/$id",
      token: token,
    );

    return GalleryItemModel.fromJson(response["data"]);
  }

  Future<GalleryItemModel> share({
    @required String type,
    @required String id,
    @required String token,
    @required String title,
    String topic,
    List<String> tags,
  }) async {
    final response = await ImgurClient.post(
      endpoint: "/3/gallery/$type/$id",
      token: token,
      queryParameters: {
        "title": title,
        "topic": topic,
        "tags": tags?.toString(),
        "terms": "1",
      },
    );

    return GalleryItemModel.fromJson(response["data"]);
  }

  Future<bool> vote({
    @required String id,
    @required String vote,
    @required String token,
  }) async {
    final response = await ImgurClient.post(
      endpoint: "/3/gallery/$id/vote/$vote",
      token: token,
    );
    final bool voted = response["data"];

    return voted;
  }
}
