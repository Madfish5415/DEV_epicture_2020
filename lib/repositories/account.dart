import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/account.dart';
import 'package:epicture/models/gallery.dart';

class AccountRepository {
  Future<List<GalleryModel>> favorites(
    String name,
    String token, {
    int page = 0,
    String sort = "newest",
  }) async {
    final response = await ImgurClient.get(
      "/3/account/$name/favorites/$page/$sort",
      token: token,
    );
    final List<Map<String, dynamic>> jsonItemList = response["data"];
    final List<GalleryModel> gallery = jsonItemList
        .map((jsonItem) => GalleryModel.fromJson(jsonItem))
        .toList();

    return gallery;
  }

  Future<AccountModel> get(
    String name, [
    String token,
  ]) async {
    final response = await ImgurClient.get(
      "/3/account/$name",
      token: token,
    );

    return AccountModel.fromJson(response["data"]);
  }

  Future<List<GalleryModel>> submissions(
      String name,
      String token, {
        int page = 0,
      }) async {
    final response = await ImgurClient.get(
      "/3/account/$name/submissions/$page",
      token: token,
    );
    final List<Map<String, dynamic>> jsonItemList = response["data"];
    final List<GalleryModel> gallery = jsonItemList
        .map((jsonItem) => GalleryModel.fromJson(jsonItem))
        .toList();

    return gallery;
  }
}
