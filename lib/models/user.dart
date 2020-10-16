import 'package:flutter/foundation.dart';

class UserModel {
  final String accessToken;
  final String refreshToken;
  final int accountId;
  final String accountUsername;

  UserModel({
    @required this.accessToken,
    @required this.refreshToken,
    @required this.accountId,
    @required this.accountUsername,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final UserModel user = UserModel(
      accessToken: map["access_token"],
      refreshToken: map["refresh_token"],
      accountId: map["account_id"],
      accountUsername: map["account_username"],
    );

    return user;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      "access_token": accessToken,
      "refresh_token": refreshToken,
      "account_id": accountId,
      "account_username": accountUsername,
    };

    return map;
  }

  @override
  String toString() {
    return "UserModel" + toMap().toString();
  }
}
