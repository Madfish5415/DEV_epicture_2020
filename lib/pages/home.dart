import 'package:epicture/blocs/gallery.dart';
import 'package:epicture/error/page.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/repositories/gallery.dart';
import 'package:epicture/widgets/bloc/bloc_provider_builder.dart';
import 'package:epicture/widgets/gallery/gallery_grid.dart';
import 'package:epicture/widgets/list/radio_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProviderBuilderWidget(
      create: (context) {
        return GalleryBloc(GalleryRepository())..add(GalleryGetEvent());
      },
      builder: (context) {
        final _HomeFilterDialog dialog = _HomeFilterDialog(context: context);

        return Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            actions: [
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  showDialog(context: context, builder: (_) => dialog);
                },
              ),
            ],
          ),
          body: BlocBuilder<GalleryBloc, GalleryState>(
            builder: (context, state) {
              if (state is GalleryGotState) {
                return _HomeGalleryGot(gallery: state.gallery);
              } else if (state is GalleryErrorState) {
                return _HomeGalleryError(error: state);
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}

class _HomeGalleryGot extends StatelessWidget {
  final List<GalleryItemModel> gallery;

  _HomeGalleryGot({
    @required this.gallery,
  });

  @override
  Widget build(BuildContext context) {
    return GalleryGridWidget(gallery: gallery);
  }
}

class _HomeGalleryError extends StatelessWidget {
  final GalleryErrorState error;

  _HomeGalleryError({
    @required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return PageErrorWidget(
      error: error,
      onPressed: () {
        GalleryBloc.of(context).add(error.event);
      },
    );
  }
}

class _HomeFilterDialog extends StatefulWidget {
  final BuildContext context;

  _HomeFilterDialog({
    @required this.context,
  });

  @override
  _HomeFilterDialogState createState() => _HomeFilterDialogState();
}

class _HomeFilterDialogState extends State<_HomeFilterDialog> {
  String _selection = "hot";
  String _sort = "viral";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListWidget(
            title: Text("Selection"),
            currentValue: _selection,
            list: {
              "hot": Text("Hot"),
              "top": Text("Top"),
              "user": Text("User"),
            },
            onChanged: (value) {
              _selection = value;
            },
          ),
          RadioListWidget(
            title: Text("Sort"),
            currentValue: _sort,
            list: {
              "viral": Text("Viral"),
              "top": Text("Top"),
              "time": Text("Time"),
            },
            onChanged: (value) {
              _sort = value;
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Confirm',
            style: TextStyle(color: Color(0xFFEE6002)),
          ),
          onPressed: () {
            GalleryBloc.of(widget.context).add(GalleryGetEvent(
              section: _selection,
              sort: _sort,
            ));

            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
