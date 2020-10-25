import 'package:epicture/blocs/gallery.dart';
import 'package:epicture/error/page.dart';
import 'package:epicture/models/gallery_tag.dart';
import 'package:epicture/repositories/gallery.dart';
import 'package:epicture/widgets/gallery/gallery_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GalleryTagModel galleryTag =
        ModalRoute.of(context).settings.arguments;

    return BlocProvider(
      create: (_) {
        return GalleryBloc(GalleryRepository())
          ..add(GalleryGetByTagEvent(tag: galleryTag.name));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(galleryTag.name),
        ),
        body: BlocBuilder<GalleryBloc, GalleryState>(
          builder: (context, state) {
            if (state is GalleryGotState) {
              return GalleryGridWidget(gallery: state.gallery);
            } else if (state is GalleryErrorState) {
              return PageErrorWidget(
                error: state,
                onPressed: () {
                  GalleryBloc.of(context).add(state.event);
                },
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
