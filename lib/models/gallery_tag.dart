import 'package:flutter/foundation.dart';

class GalleryTagModel {
  final int id;
  final String name;
  final String title;
  final String coverId;
  final int followers;
  final int items;

  GalleryTagModel({
    @required this.id,
    @required this.name,
    @required this.title,
    @required this.coverId,
    @required this.followers,
    @required this.items,
  });

  factory GalleryTagModel.fromJson(Map<String, dynamic> json) {
    final GalleryTagModel galleryTag = GalleryTagModel(
      id: json["id"],
      name: json["name"],
      title: json["title"],
      coverId: json["background_hash"],
      followers: json["followers"],
      items: json["total_items"],
    );

    return galleryTag;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      "id": id,
      "name": name,
      "title": title,
      "cover_id": coverId,
      "followers": followers,
      "items": items,
    };

    return map;
  }

  @override
  String toString() {
    return "GalleryTagModel" + toMap().toString();
  }
}
