import 'package:epicture/blocs/image.dart';
import 'package:epicture/blocs/image/bloc.dart';
import 'package:epicture/models/gallery_tag.dart';
import 'package:epicture/repositories/image.dart';
import 'package:epicture/utilities/palette.dart';
import 'package:epicture/widgets/bloc/bloc_provider_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryTagCard extends StatelessWidget {
  final GalleryTagModel _tag;

  GalleryTagCard(this._tag);

  @override
  Widget build(BuildContext context) {
    return BlocProviderBuilderWidget(create: (context) {
      return ImageBloc(ImageRepository())..add(ImageGetEvent(id: _tag.coverId));
    }, builder: (context) {
      return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state is ImageGotState) {
              final image = NetworkImage(state.image.url);

              return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  )),
                  child: FutureBuilder(
                    future: getImagePalette(image),
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Chip(
                                elevation: 10,
                                backgroundColor: (snapshot.hasData)
                                    ? snapshot.data
                                    : Colors.black,
                                label: Text(
                                  _tag.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: (snapshot.hasData)
                                  ? snapshot.data
                                  : Colors.black,
                              child: Center(
                                child: Text(
                                  _tag.followers.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ));
            } else if (state is ImageErrorState) {
              return Center(child: Text(state.message));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      );
    });
  }
}
