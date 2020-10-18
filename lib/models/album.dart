import 'package:epicture/models/image.dart';
import 'package:flutter/foundation.dart';

class AlbumModel {
  final int id;
  final String url;
  final int coverId;
  final String title;
  final String description;
  final int views;
  final bool favorite;
  final List<ImageModel> images;

  AlbumModel({
    @required this.id,
    @required this.url,
    @required this.coverId,
    @required this.images,
    this.title,
    this.description,
    this.views,
    this.favorite,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> imageJsonList = json["images"];
    final List<ImageModel> images = imageJsonList
        .map((imageJson) => ImageModel.fromJson(imageJson))
        .toList();

    final AlbumModel album = AlbumModel(
      id: json["id"],
      url: json["link"],
      coverId: json["cover"],
      title: json["title"],
      description: json["description"],
      views: json["views"],
      favorite: json["favorite"],
      images: images,
    );

    return album;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      "id": id,
      "url": url,
      "cover_id": coverId,
      "title": title,
      "description": description,
      "views": views,
      "favorite": favorite,
      "images": images.toString(),
    };

    return map;
  }

  @override
  String toString() {
    return "AlbumModel" + toMap().toString();
  }
}
