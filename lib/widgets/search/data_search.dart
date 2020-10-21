import 'package:epicture/blocs/gallery.dart';
import 'package:epicture/blocs/gallery/bloc.dart';
import 'package:epicture/blocs/gallery/event.dart';
import 'package:epicture/repositories/gallery.dart';
import 'package:epicture/widgets/gallery_item/gallery_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataSearch extends SearchDelegate<String> {
  DataSearch();

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = '';
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    
    return BlocProvider(
      create: (context) {
        return GalleryBloc(GalleryRepository())..add(GallerySearchEvent(query: query));
      },
      child: BlocBuilder<GalleryBloc, GalleryState>(
        builder: (context, state) {
          if (state is GalleryGotState) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 8 / 10,
              ),
              itemCount: state.gallery.length,
              itemBuilder: (context, index) {
                return GalleryItemCard(
                  galleryItem: state.gallery[index],
                );
              },
            );
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
