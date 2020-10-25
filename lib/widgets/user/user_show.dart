import 'package:epicture/blocs/user.dart';
import 'package:epicture/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef UserShowWidgetBuilder = Widget Function(
    BuildContext context, UserModel user);

class UserShowWidget extends StatelessWidget {
  final UserShowWidgetBuilder builder;

  UserShowWidget({
    @required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoggedInState) {
          return builder(context, state.user);
        }

        return Container();
      },
    );
  }
}
