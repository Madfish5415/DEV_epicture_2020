import 'package:epicture/blocs/gallery_tags.dart';
import 'package:epicture/models/gallery_tag.dart';
import 'package:epicture/repositories/gallery_tags.dart';
import 'package:epicture/widgets/gallery_item/gallery_tag_card.dart';
import 'package:epicture/widgets/search/data_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GalleryTagsBloc(GalleryTagsRepository())
          ..add(GalleryTagsGetEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
          ],
        ),
        body: BlocBuilder<GalleryTagsBloc, GalleryTagsState>(
          builder: (context, state) {
            if (state is GalleryTagsGotState) {
              return _SearchGalleryTagsGot(galleryTags: state.galleryTags);
            } else if (state is GalleryTagsErrorState) {
              return _SearchGalleryTagsError(error: state);
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _SearchGalleryTagsGot extends StatelessWidget {
  final List<GalleryTagModel> galleryTags;

  const _SearchGalleryTagsGot({
    @required this.galleryTags,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: galleryTags.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1,
      ),
      itemBuilder: (context, index) {
        return GalleryTagCard(galleryTag: galleryTags[index]);
      },
    );
  }
}

class _SearchGalleryTagsError extends StatelessWidget {
  final GalleryTagsErrorState error;

  _SearchGalleryTagsError({
    @required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error.message),
          TextButton(
            onPressed: () {
              GalleryTagsBloc.of(context).add(error.event);
            },
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }
}
