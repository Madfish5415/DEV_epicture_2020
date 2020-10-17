import 'package:epicture/models/album.dart';
import 'package:epicture/models/gallery_tag.dart';
import 'package:epicture/models/image.dart';
import 'package:flutter/foundation.dart';

class GalleryItemModel {
  final dynamic child;
  final int favorites;
  final int ups;
  final int downs;
  final int score;
  final List<GalleryTagModel> tags;

  GalleryItemModel({
    @required this.child,
    @required this.favorites,
    @required this.ups,
    @required this.downs,
    @required this.score,
    this.tags,
  });

  factory GalleryItemModel.fromJson(Map<String, dynamic> json) {
    final dynamic child = (json["is_album"])
        ? AlbumModel.fromJson(json)
        : ImageModel.fromJson(json);
    final List<Map<String, dynamic>> tagJsonList = json["tags"];
    final List<GalleryTagModel> tags = tagJsonList
        .map((tagJson) => GalleryTagModel.fromJson(tagJson))
        .toList();

    final GalleryItemModel gallery = GalleryItemModel(
      child: child,
      favorites: json["favorite_count"],
      ups: json["ups"],
      downs: json["downs"],
      score: json["score"],
      tags: tags,
    );

    return gallery;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      "favorites": favorites,
      "ups": ups,
      "downs": downs,
      "score": score,
      "child": child.toMap(),
    };

    return map;
  }

  @override
  String toString() {
    return "GalleryModel" + toMap().toString();
  }
}
