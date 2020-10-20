import 'package:epicture/blocs/user.dart';
import 'package:epicture/models/user.dart';
import 'package:flutter/foundation.dart';

class UserState {
  const UserState();
}

class UserInitialState extends UserState {
  const UserInitialState();
}

class UserLoadingState extends UserState {
  const UserLoadingState();
}

class UserLoggedInState extends UserState {
  final UserModel user;

  const UserLoggedInState({@required this.user});
}

class UserLoggedOutState extends UserState {
  const UserLoggedOutState();
}

class UserErrorState extends UserState {
  final UserEvent event;
  final String message;

  const UserErrorState({
    @required this.event,
    this.message,
  });
}
