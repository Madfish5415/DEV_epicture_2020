import 'package:epicture/blocs/user.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/pages/profile/account.dart';
import 'package:epicture/pages/profile/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoggedInState) {
          return _ProfileUserLoggedIn(user: state.user);
        } else if (state is UserLoggedOutState) {
          return _ProfileUserLoggedOut();
        } else if (state is UserErrorState) {
          return _ProfileUserError(error: state);
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _ProfileUserLoggedOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileLoginPage();
  }
}

class _ProfileUserLoggedIn extends StatelessWidget {
  final UserModel user;

  const _ProfileUserLoggedIn({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileAccountPage(user: user);
  }
}

class _ProfileUserError extends StatelessWidget {
  final UserErrorState error;

  _ProfileUserError({
    @required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error.message),
          TextButton(
            onPressed: () {
              UserBloc.of(context).add(error.event);
            },
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }
}
