import 'package:epicture/blocs/user.dart';
import 'package:flutter/material.dart';

class ProfileLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          UserBloc.of(context).add(UserLogInEvent());
        },
        child: Text("Login"),
      ),
    );
  }
}
