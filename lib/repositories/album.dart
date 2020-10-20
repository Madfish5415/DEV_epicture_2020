import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/album.dart';
import 'package:flutter/foundation.dart';

class AlbumRepository {
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
