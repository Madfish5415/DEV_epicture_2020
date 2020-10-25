import 'package:epicture/blocs/account.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/repositories/account.dart';
import 'package:epicture/repositories/album.dart';
import 'package:epicture/widgets/gallery/gallery_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileAccountFavoritesWidget extends StatelessWidget {
  final UserModel user;

  const ProfileAccountFavoritesWidget({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AccountBloc(AccountRepository(), AlbumRepository())
          ..add(AccountGetFavoritesEvent(token: user.accessToken));
      },
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountGotFavoritesState) {
            return GalleryGridWidget(gallery: state.favorites);
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
