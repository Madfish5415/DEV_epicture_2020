import 'package:epicture/blocs/image.dart';
import 'package:epicture/models/image.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/repositories/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageFavoriteActionWidget extends StatelessWidget {
  final ImageModel image;
  final UserModel user;

  ImageFavoriteActionWidget({
    @required this.image,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ImageBloc(ImageRepository())
          ..add(ImageGetEvent(
            id: image.id,
            token: user.accessToken,
          ));
      },
      child: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          bool favorited = false;

          if (state is ImageGotState) {
            favorited = state.image.favorite;
          } else if (state is ImageFavoritedState) {
            favorited = state.favorited;
          }

          return _ImageFavoriteButton(
            id: image.id,
            token: user.accessToken,
            state: favorited,
          );
        },
      ),
    );
  }
}

class _ImageFavoriteButton extends StatelessWidget {
  final String id;
  final String token;
  final bool state;

  _ImageFavoriteButton({
    @required this.id,
    @required this.token,
    @required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon((!state) ? Icons.favorite_border : Icons.favorite),
      color: (!state) ? Colors.black : Colors.red,
      onPressed: () {
        ImageBloc.of(context).add(
          ImageFavoriteEvent(
            id: id,
            token: token,
          ),
        );
      },
    );
  }
}
