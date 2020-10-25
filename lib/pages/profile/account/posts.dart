import 'package:epicture/blocs/account.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/repositories/account.dart';
import 'package:epicture/repositories/album.dart';
import 'package:epicture/widgets/gallery/gallery_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAccountPostsWidget extends StatelessWidget {
  final UserModel user;

  const ProfileAccountPostsWidget({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AccountBloc(AccountRepository(), AlbumRepository())
          ..add(AccountGetPostsEvent(token: user.accessToken));
      },
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountGotPostsState) {
            return GalleryGridWidget(gallery: state.posts);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
