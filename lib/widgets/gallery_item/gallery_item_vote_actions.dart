import 'package:epicture/blocs/gallery_item.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/repositories/gallery_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryItemVoteActionsWidget extends StatelessWidget {
  final GalleryItemModel galleryItem;
  final UserModel user;

  GalleryItemVoteActionsWidget({
    @required this.galleryItem,
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GalleryItemBloc(GalleryItemRepository())
          ..add(GalleryItemGetEvent(
            type: galleryItem.type,
            id: galleryItem.child.id,
            token: user.accessToken,
          ));
      },
      child: BlocBuilder<GalleryItemBloc, GalleryItemState>(
        builder: (context, state) {
          String vote;

          if (state is GalleryItemGotState) {
            vote = state.galleryItem.vote;
          } else if (state is GalleryItemVotedState) {
            vote = state.vote;
          }

          bool upVoted = (vote == "up");
          bool downVoted = (vote == "down");

          return Row(
            children: [
              _ImageItemActionsUpVoteButton(
                  id: galleryItem.child.id,
                  token: user.accessToken,
                  state: upVoted),
              _ImageItemActionsDownVoteButton(
                  id: galleryItem.child.id,
                  token: user.accessToken,
                  state: downVoted),
            ],
          );
        },
      ),
    );
  }
}

class _ImageItemActionsUpVoteButton extends StatelessWidget {
  final String id;
  final String token;
  final bool state;

  _ImageItemActionsUpVoteButton({
    @required this.id,
    @required this.token,
    @required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_upward),
      color: (!state) ? Theme.of(context).iconTheme.color : Colors.green,
      onPressed: () {
        GalleryItemBloc.of(context).add(
          GalleryItemVoteEvent(
            id: id,
            vote: (!state) ? "up" : "veto",
            token: token,
          ),
        );
      },
    );
  }
}

class _ImageItemActionsDownVoteButton extends StatelessWidget {
  final String id;
  final String token;
  final bool state;

  _ImageItemActionsDownVoteButton({
    @required this.id,
    @required this.token,
    @required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_downward),
      color: (!state) ? Theme.of(context).iconTheme.color : Colors.red,
      onPressed: () {
        GalleryItemBloc.of(context).add(
          GalleryItemVoteEvent(
            id: id,
            vote: (!state) ? "down" : "veto",
            token: token,
          ),
        );
      },
    );
  }
}
