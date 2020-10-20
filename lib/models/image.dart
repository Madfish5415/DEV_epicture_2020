import 'package:flutter/foundation.dart';

class ImageModel {
  final String id;
  final String url;
  final String type;
  final int width;
  final int height;
  final String title;
  final String description;
  final int views;
  final bool favorite;

  ImageModel({
    @required this.id,
    @required this.url,
    @required this.type,
    @required this.width,
    @required this.height,
    this.title,
    this.description,
    this.views,
    this.favorite,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    final ImageModel image = ImageModel(
      id: json["id"],
      url: json["link"],
      type: json["type"],
      width: json["width"],
      height: json["height"],
      title: json["title"],
      description: json["description"],
      views: json["views"],
      favorite: json["favorite"],
    );

    return image;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      "id": id,
      "url": url,
      "type": type,
      "width": width,
      "height": height,
      "title": title,
      "description": description,
      "views": views,
      "favorite": favorite,
    };

    return map;
  }

  @override
  String toString() {
    return "ImageModel" + toMap().toString();
  }
}
