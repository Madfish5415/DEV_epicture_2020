import 'package:flutter/foundation.dart';

class AccountModel {
  final String id;
  final String username;
  final String biography;
  final String avatarUrl;
  final String coverUrl;
  final int reputation;
  final String reputationName;

  AccountModel({
    @required this.id,
    @required this.username,
    this.biography,
    this.avatarUrl,
    this.coverUrl,
    this.reputation,
    this.reputationName,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    final AccountModel account = AccountModel(
      id: json["id"],
      username: json["url"],
      biography: json["bio"],
      avatarUrl: json["avatar"],
      coverUrl: json["cover"],
      reputation: json["reputation"],
      reputationName: json["reputation_name"],
    );

    return account;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      "id": id,
      "username": username,
      "biography": biography,
      "avatar_url": avatarUrl,
      "cover_url": coverUrl,
      "reputation": reputation,
      "reputation_name": reputationName,
    };

    return map;
  }

  @override
  String toString() {
    return "AccountModel" + toMap().toString();
  }
}
