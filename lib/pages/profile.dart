import 'package:epicture/blocs/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoggedInState) {
          return _ProfileUserLoggedInWidget(state: state);
        } else if (state is UserLoggedOutState) {
          return _ProfileUserLoggedOutWidget();
        } else if (state is UserErrorState) {
          return _HomeUserErrorWidget(error: state);
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _ProfileUserLoggedOutWidget extends StatelessWidget {
  const _ProfileUserLoggedOutWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          UserBloc.of(context).add(
            UserLogInEvent(),
          );
        },
        child: Text("Login"),
      ),
    );
  }
}

class _ProfileUserLoggedInWidget extends StatelessWidget {
  final UserLoggedInState state;

  const _ProfileUserLoggedInWidget({
    Key key,
    @required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.user.accessToken),
          Text(state.user.refreshToken),
          RaisedButton(
            onPressed: () {
              UserBloc.of(context).add(UserLogOutEvent());
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}

class _HomeUserErrorWidget extends StatelessWidget {
  final UserErrorState error;

  _HomeUserErrorWidget({
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
