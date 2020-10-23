import 'package:epicture/imgur/client.dart';
import 'package:epicture/models/account.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:flutter/foundation.dart';

class AccountRepository {
  Future<List<GalleryItemModel>> favorites({
    @required String name,
    @required String token,
    int page = 0,
    String sort = "newest",
  }) async {
    final response = await ImgurClient.get(
      endpoint: "/3/account/$name/favorites/$page/$sort",
      token: token,
    );
    final List<dynamic> jsonItemList = response["data"];
    final List<GalleryItemModel> gallery = jsonItemList
        .map((jsonItem) => GalleryItemModel.fromJson(jsonItem))
        .toList();

    return gallery;
  }

  Future<AccountModel> get({
    @required String name,
    String token,
  }) async {
    final response = await ImgurClient.get(
      endpoint: "/3/account/$name",
      token: token,
    );

    return AccountModel.fromJson(response["data"]);
  }

  Future<List<GalleryItemModel>> posts({
    @required String name,
    @required String token,
    int page = 0,
  }) async {
    final response = await ImgurClient.get(
      endpoint: "/3/account/$name/images/$page",
      token: token,
    );
    final List<dynamic> jsonItemList = response["data"];
    final List<GalleryItemModel> gallery = jsonItemList
        .map((jsonItem) => GalleryItemModel.fromJson(jsonItem))
        .toList();

    return gallery;
  }
}
