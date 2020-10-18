import 'package:epicture/models/user.dart';

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

  const UserLoggedInState(this.user);
}

class UserLoggedOutState extends UserState {
  const UserLoggedOutState();
}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState(this.message);
}
