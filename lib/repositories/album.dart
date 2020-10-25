import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/album.dart';
import 'package:flutter/foundation.dart';

class AlbumRepository {
  Future<bool> favorite({
    @required String id,
    @required String token,
  }) async {
    final response = await ImgurClient.post(
      endpoint: "/3/album/$id/favorite",
      token: token,
    );
    final bool favorited = (response["data"] == "favorited");

    return favorited;
  }

  Future<AlbumModel> get({
    @required String id,
    String token,
  }) async {
    final response = await ImgurClient.get(
      endpoint: "/3/album/$id",
      token: token,
    );

    return AlbumModel.fromJson(response["data"]);
  }
}
