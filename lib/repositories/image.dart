import 'dart:io';

import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/image.dart';

class ImageRepository {
  Future<ImageModel> delete(
      int id,
      String token,
      ) async {
    final response = await ImgurClient.delete(
      "/3/image/$id",
      token: token,
    );

    return ImageModel.fromJson(response["data"]);
  }

  Future<ImageModel> favorite(
      int id,
      String token,
      ) async {
    final response = await ImgurClient.post(
      "/3/image/$id/favorite",
      token: token,
    );

    return ImageModel.fromJson(response["data"]);
  }

  Future<ImageModel> get(
    int id,
  ) async {
    final response = await ImgurClient.get(
      "/3/image/$id",
    );

    return ImageModel.fromJson(response["data"]);
  }

  Future<ImageModel> update(
    int id,
    String title,
    String description,
    String token,
  ) async {
    final response = await ImgurClient.post(
      "/3/image/$id",
      token: token,
      body: {
        "title": title,
        "description": description,
      },
    );

    return ImageModel.fromJson(response["data"]);
  }

  Future<ImageModel> upload(
    String field,
    File file,
    String title,
    String description,
    String token,
  ) async {
    final response = await ImgurClient.postMultipart(
      "/3/upload",
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
