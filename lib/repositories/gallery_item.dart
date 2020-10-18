import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:flutter/foundation.dart';

class GalleryItemRepository {
  Future<GalleryItemModel> get({
    @required String type,
    @required int id,
  }) async {
    final response = await ImgurClient.get(
      endpoint: "/3/gallery/$type/$id",
    );

    return GalleryItemModel.fromJson(response["data"]);
  }

  Future<GalleryItemModel> remove({
    @required int id,
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
    @required int id,
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
        "tags": tags,
        "terms": 1,
      },
    );

    return GalleryItemModel.fromJson(response["data"]);
  }

  Future<GalleryItemModel> vote({
    @required int id,
    @required String vote,
    @required String token,
  }) async {
    final response = await ImgurClient.post(
      endpoint: "/3/gallery/$id/vote/$vote",
      token: token,
    );

    return GalleryItemModel.fromJson(response["data"]);
  }
}
