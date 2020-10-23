import 'package:epicture/blocs/account.dart';
import 'package:epicture/blocs/common/state.dart';
import 'package:epicture/models/account.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:flutter/foundation.dart';

abstract class AccountState {
  const AccountState();
}

class AccountInitialState extends AccountState {
  const AccountInitialState();
}

class AccountLoadingState extends AccountState {
  const AccountLoadingState();
}

class AccountGotState extends AccountState {
  final AccountModel account;

  const AccountGotState({@required this.account});
}

class AccountGotFavoritesState extends AccountState {
  final List<GalleryItemModel> favorites;

  const AccountGotFavoritesState({@required this.favorites});
}

class AccountGotPostsState extends AccountState {
  final List<GalleryItemModel> posts;

  const AccountGotPostsState({@required this.posts});
}

class AccountErrorState extends AccountState implements ErrorState {
  final AccountEvent event;
  final String message;

  const AccountErrorState({
    @required this.event,
    this.message,
  });
}
