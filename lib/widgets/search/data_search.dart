import 'package:epicture/blocs/gallery.dart';
import 'package:epicture/blocs/gallery/bloc.dart';
import 'package:epicture/blocs/gallery/event.dart';
import 'package:epicture/repositories/gallery.dart';
import 'package:epicture/widgets/gallery/gallery_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataSearch extends SearchDelegate<String> {
@override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return GalleryBloc(GalleryRepository())
          ..add(GallerySearchEvent(query: query));
      },
      child: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          if (state is GalleryGotState) {
            return GalleryGridWidget(gallery: state.gallery);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
