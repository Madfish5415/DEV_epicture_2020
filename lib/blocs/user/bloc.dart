import 'package:epicture/blocs/user/event.dart';
import 'package:epicture/blocs/user/state.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/repositories/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;

  static UserBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  UserBloc(this._repository) : super(UserInitialState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    yield UserLoadingState();

    if (event is UserLogInEvent) {
      yield* _login(event);
    } else if (event is UserLogOutEvent) {
      yield* _logout(event);
    }
  }

  Stream<UserState> _login(UserLogInEvent event) async* {
    try {
      final UserModel user = await _repository.login();

      yield UserLoggedInState(user: user);
    } on Exception catch (e) {
      yield UserErrorState(message: e.toString());
    }
  }

  Stream<UserState> _logout(UserLogOutEvent event) async* {
    try {
      await _repository.logout();

      yield UserLoggedOutState();
    } on Exception catch (e) {
      yield UserErrorState(message: e.toString());
    }
  }
}
