import 'package:epicture/blocs/gallery.dart';
import 'package:epicture/models/gallery_tag.dart';
import 'package:epicture/repositories/gallery.dart';
import 'package:epicture/widgets/gallery_item/gallery_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagScreen extends StatelessWidget {
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
      ),
    );
  }
}
