import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/album.dart';

class AlbumRepository {
  Future<AlbumModel> get(
    int id,
  ) async {
    final response = await ImgurClient.get(
      "/3/album/$id",
    );

    return AlbumModel.fromJson(response["data"]);
  }
}
