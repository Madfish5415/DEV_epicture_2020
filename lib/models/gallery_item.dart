import 'package:epicture/models/album.dart';
import 'package:epicture/models/gallery_tag.dart';
import 'package:epicture/models/image.dart';
import 'package:flutter/foundation.dart';

class GalleryItemModel {
  final dynamic child;
  final String type;
  final int favorites;
  final int ups;
  final int downs;
  final int score;
  final List<GalleryTagModel> tags;
  final String vote;

  GalleryItemModel({
    @required this.child,
    @required this.type,
    @required this.favorites,
    @required this.ups,
    @required this.downs,
    @required this.score,
    this.tags,
    this.vote,
  });

  factory GalleryItemModel.fromJson(Map<String, dynamic> json) {
    final dynamic child = (json["is_album"])
        ? AlbumModel.fromJson(json)
        : ImageModel.fromJson(json);
    final String type = (json["is_album"]) ? "album" : "image";
    final List<dynamic> tagJsonList = json["tags"];
    final List<GalleryTagModel> tags = tagJsonList
        .map((tagJson) => GalleryTagModel.fromJson(tagJson))
        .toList();

    final GalleryItemModel gallery = GalleryItemModel(
      child: child,
      type: type,
      favorites: json["favorite_count"],
      ups: json["ups"],
      downs: json["downs"],
      score: json["score"],
      tags: tags,
      vote: json["vote"],
    );

    return gallery;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      "child": child.toMap(),
      "type": type,
      "favorites": favorites,
      "ups": ups,
      "downs": downs,
      "score": score,
      "tags": tags,
      "vote": vote,
    };

    return map;
  }

  @override
  String toString() {
    return "GalleryModel" + toMap().toString();
  }
}
