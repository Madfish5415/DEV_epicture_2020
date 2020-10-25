import 'dart:io';

import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/image.dart';
import 'package:flutter/foundation.dart';

class ImageRepository {
  Future<bool> delete({
    @required String id,
    @required String token,
  }) async {
    final response = await ImgurClient.delete(
      endpoint: "/3/image/$id",
      token: token,
    );
    final bool deleted = response["data"];

    return deleted;
  }

  Future<bool> favorite({
    @required String id,
    @required String token,
  }) async {
    final response = await ImgurClient.post(
      endpoint: "/3/image/$id/favorite",
      token: token,
    );
    final bool favorited = (response["data"] == "favorited");

    return favorited;
  }

  Future<ImageModel> get({
    @required String id,
    String token,
  }) async {
    final response = await ImgurClient.get(
      endpoint: "/3/image/$id",
      token: token,
    );

    return ImageModel.fromJson(response["data"]);
  }

  Future<bool> update({
    @required String id,
    @required String token,
    String title,
    String description,
  }) async {
    final response = await ImgurClient.post(
      endpoint: "/3/image/$id",
      token: token,
      body: {
        "title": title,
        "description": description,
      },
    );
    final bool updated = response["data"];

    return updated;
  }

  Future<ImageModel> upload({
    @required String token,
    @required String field,
    @required File file,
    String title,
    String description,
  }) async {
    final response = await ImgurClient.postMultipart(
      endpoint: "/3/upload",
      token: token,
      body: {
        "type": "file",
        "title": title,
        "description": description,
      },
      field: field,
      file: file,
    );

    return ImageModel.fromJson(response["data"]);
  }
}
