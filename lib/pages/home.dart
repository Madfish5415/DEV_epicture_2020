import 'package:epicture/blocs/gallery.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/repositories/gallery.dart';
import 'package:epicture/widgets/bloc/bloc_provider_builder.dart';
import 'package:epicture/widgets/list/radio_list.dart';
import 'package:epicture/widgets/gallery_item/gallery_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
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
                return _HomeGalleryGotWidget(gallery: state.gallery);
              } else if (state is GalleryErrorState) {
                return _HomeGalleryErrorWidget(error: state);
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }
}

class _HomeGalleryGotWidget extends StatelessWidget {
  final List<GalleryItemModel> gallery;

  _HomeGalleryGotWidget({
    @required this.gallery,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 8 / 10,
      ),
      itemCount: gallery.length,
      itemBuilder: (context, index) {
        return GalleryItemCard(
          galleryItem: gallery[index],
        );
      },
    );
  }
}

class _HomeGalleryErrorWidget extends StatelessWidget {
  final GalleryErrorState error;

  _HomeGalleryErrorWidget({
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
              GalleryBloc.of(context).add(error.event);
            },
            child: Text("Retry"),
          ),
        ],
      ),
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
          child: Text('Confirm'),
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
