import 'package:epicture/blocs/image.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/models/image.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/repositories/image.dart';
import 'package:epicture/router.dart';
import 'package:epicture/widgets/image/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RouteSettings routeSettings = ModalRoute.of(context).settings;
    final Map<String, dynamic> routeArguments = routeSettings.arguments;
    final UserModel user = routeArguments["user"];
    final ImageModel image = routeArguments["image"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: BlocProvider(
        create: (context) {
          return ImageBloc(ImageRepository());
        },
        child: BlocListener<ImageBloc, ImageState>(
          listener: (context, state) {
            if (state is ImageGotState) {
              AppRouter.navigator.pushReplacementNamed(
                "/view",
                arguments: GalleryItemModel(
                  child: state.image,
                  type: "image",
                  public: false,
                ),
              );
            } else if (state is ImageUpdatedState) {
              ImageBloc.of(context).add(ImageGetEvent(id: image.id));
            } else if (state is ImageDeletedState) {
              AppRouter.navigator.popUntil((route) => route.isFirst);
            }
          },
          child: BlocBuilder<ImageBloc, ImageState>(
            builder: (context, state) {
              if (state is ImageInitialState) {
                return _EditImageInitial(
                  user: user,
                  image: image,
                );
              } else if (state is ImageErrorState) {
                return _EditImageError(error: state);
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

class _EditImageInitial extends StatelessWidget {
  final UserModel user;
  final ImageModel image;

  _EditImageInitial({
    @required this.user,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ImageViewWidget(image: image),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _EditForm(
              user: user,
              image: image,
            ),
          )
        ],
      ),
    );
  }
}

class _EditForm extends StatefulWidget {
  final UserModel user;
  final ImageModel image;

  _EditForm({
    @required this.user,
    @required this.image,
  });

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<_EditForm> {
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _description;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.title),
              hintText: "Title",
            ),
            initialValue: widget.image.title,
            onSaved: (value) {
              _title = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.description_outlined),
              hintText: "Description",
            ),
            initialValue: widget.image.description,
            onSaved: (value) {
              _description = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  ImageBloc.of(context).add(ImageUpdateEvent(
                    token: widget.user.accessToken,
                    id: widget.image.id,
                    title: _title,
                    description: _description,
                  ));
                }
              },
              child: Text("Edit"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: RaisedButton(
              onPressed: () {
                ImageBloc.of(context).add(ImageDeleteEvent(
                  token: widget.user.accessToken,
                  id: widget.image.id,
                ));
              },
              child: Text("Delete"),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditImageError extends StatelessWidget {
  final ImageErrorState error;

  _EditImageError({
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
              ImageBloc.of(context).add(error.event);
            },
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }
}
