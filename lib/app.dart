import 'package:epicture/blocs/user.dart';
import 'package:epicture/repositories/user.dart';
import 'package:epicture/router.dart';
import 'package:epicture/themer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UserBloc(UserRepository())..add(UserLogOutEvent());
      },
      child: MaterialApp(
        title: "Epicture",
        navigatorKey: AppRouter.navigatorKey,
        onGenerateRoute: AppRouter.generateRoute,
        theme: AppThemer.dark,
      ),
    );
  }
}
