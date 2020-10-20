import 'package:epicture/blocs/gallery_tags.dart';
import 'package:epicture/repositories/gallery_tags.dart';
import 'package:epicture/widgets/gallery_item/gallery_tag_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return GalleryTagsBloc(GalleryTagsRepository())
          ..add(GalleryTagsGetEvent());
      },
      child: BlocBuilder<GalleryTagsBloc, GalleryTagsState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Search"),
              ),
              body: Builder(
                builder: (context) {
                  if (state is GalleryTagsGotState) {
                    return GridView.builder(
                      itemCount: state.galleryTags.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1 / 1,
                      ),
                      itemBuilder: (context, index) {
                        return GalleryTagCard(state.galleryTags[index]);
                      },
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ));
        },
      ),
    );
  }
}
