import 'dart:io';

import 'package:epicture/blocs/image.dart';
import 'package:epicture/blocs/picker.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/repositories/image.dart';
import 'package:epicture/repositories/picker.dart';
import 'package:epicture/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Upload"),
      ),
      body: BlocProvider(
        create: (context) {
          return PickerBloc(PickerRepository());
        },
        child: BlocBuilder<PickerBloc, PickerState>(
          builder: (context, state) {
            if (state is PickerInitialState) {
              return _UploadPickerInitial();
            } else if (state is PickerGotState) {
              return _UploadPickerGot(
                user: user,
                file: state.file,
              );
            } else if (state is PickerErrorState) {
              return _UploadPickerError(error: state);
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _UploadPickerInitial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            iconSize: 256,
            onPressed: () {
              PickerBloc.of(context).add(PickerGetCameraEvent());
            },
          ),
          IconButton(
            icon: Icon(Icons.image),
            iconSize: 256,
            onPressed: () {
              PickerBloc.of(context).add(PickerGetGalleryEvent());
            },
          ),
        ],
      ),
    );
  }
}

class _UploadPickerGot extends StatelessWidget {
  final UserModel user;
  final File file;

  _UploadPickerGot({
    @required this.user,
    @required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ImageBloc(ImageRepository());
      },
      child: BlocListener<ImageBloc, ImageState>(
        listener: (context, state) {
          if (state is ImageUploadedState) {
            AppRouter.navigator.pushReplacementNamed(
              "/view",
              arguments: GalleryItemModel(
                child: state.image,
                type: "image",
                public: false,
              ),
            );
          }
        },
        child: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state is ImageInitialState) {
              return _UploadImageInitial(
                user: user,
                file: file,
              );
            } else if (state is ImageErrorState) {
              return _UploadImageError(error: state);
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class _UploadPickerError extends StatelessWidget {
  final PickerErrorState error;

  _UploadPickerError({
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
              PickerBloc.of(context).add(error.event);
            },
            child: Text("Retry"),
          ),
        ],
      ),
    );
  }
}

class _UploadImageInitial extends StatelessWidget {
  final UserModel user;
  final File file;

  _UploadImageInitial({
    @required this.user,
    @required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.file(file),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _UploadForm(
              user: user,
              file: file,
            ),
          )
        ],
      ),
    );
  }
}

class _UploadForm extends StatefulWidget {
  final UserModel user;
  final File file;

  _UploadForm({
    @required this.user,
    @required this.file,
  });

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<_UploadForm> {
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
            onSaved: (value) {
              _title = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.description_outlined),
              hintText: "Description",
            ),
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

                  ImageBloc.of(context).add(ImageUploadEvent(
                    token: widget.user.accessToken,
                    field: "image",
                    file: widget.file,
                    title: _title,
                    description: _description,
                  ));
                }
              },
              child: Text("Upload"),
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadImageError extends StatelessWidget {
  final ImageErrorState error;

  _UploadImageError({
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
