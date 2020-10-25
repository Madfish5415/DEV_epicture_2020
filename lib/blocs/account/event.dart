import 'package:epicture/blocs/common/event.dart';

abstract class AccountEvent extends Event {
  const AccountEvent();
}

class AccountGetEvent extends AccountEvent {
  final String name;
  final String token;

  const AccountGetEvent({
    this.name = "me",
    this.token,
  });
}

class AccountGetFavoritesEvent extends AccountEvent {
  final String name;
  final String token;

  const AccountGetFavoritesEvent({
    this.name = "me",
    this.token,
  });
}

class AccountGetPostsEvent extends AccountEvent {
  final String name;
  final String token;

  const AccountGetPostsEvent({
    this.name = "me",
    this.token,
  });
}
