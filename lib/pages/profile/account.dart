import 'package:epicture/blocs/account.dart';
import 'package:epicture/blocs/user.dart';
import 'package:epicture/error/page.dart';
import 'package:epicture/models/account.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/pages/profile/account/favorites.dart';
import 'package:epicture/pages/profile/account/posts.dart';
import 'package:epicture/repositories/account.dart';
import 'package:epicture/router.dart';
import 'package:epicture/widgets/account/account_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAccountPage extends StatelessWidget {
  final UserModel user;

  ProfileAccountPage({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AccountBloc(AccountRepository())
          ..add(AccountGetEvent(token: user.accessToken));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                UserBloc.of(context).add(UserLogOutEvent());
              },
            ),
          ],
        ),
        body: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            if (state is AccountGotState) {
              return _ProfileAccountGot(account: state.account, user: user);
            } else if (state is AccountErrorState) {
              return PageErrorWidget(
                error: state,
                onPressed: () {
                  AccountBloc.of(context).add(state.event);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.file_upload),
          onPressed: () {
            AppRouter.navigator.pushNamed("/upload", arguments: user);
          },
        ),
      ),
    );
  }
}

class _ProfileAccountGot extends StatelessWidget {
  final UserModel user;
  final AccountModel account;

  _ProfileAccountGot({
    @required this.user,
    @required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            AccountCardWidget(account: account),
            Container(
              child: TabBar(
                tabs: [
                  Tab(text: "Favorites"),
                  Tab(text: "Posts"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ProfileAccountFavoritesWidget(user: user),
                  ProfileAccountPostsWidget(user: user),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
