import 'dart:io';

import 'package:epicture/blocs/image.dart';
import 'package:epicture/models/gallery_item.dart';
import 'package:epicture/models/user.dart';
import 'package:epicture/repositories/image.dart';
import 'package:epicture/router.dart';
import 'package:epicture/widgets/bloc/bloc_provider_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserModel user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Upload"),
      ),
      body: BlocProviderBuilderWidget(
        create: (context) {
          return ImageBloc(ImageRepository());
        },
        builder: (context) => BlocListener<ImageBloc, ImageState>(
          listener: (context, state) {
            if (state is ImageUpdatedState) {
              AppRouter.navigator.pushReplacementNamed(
                "/view",
                arguments: GalleryItemModel(
                  child: state.image,
                  type: "image",
                  public: false,
                ),
              );
            } else if (state is ImageErrorState) {
              print(state.message);
            }
          },
          child: BlocBuilder<ImageBloc, ImageState>(
            builder: (context, state) {
              if (state is ImageInitialState) {
                return _UploadImageInitial(user: user);
              } else if (state is ImageErrorState) {
                return _UploadImageError(error: state);
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

class _UploadImageInitial extends StatelessWidget {
  final UserModel user;
  final ImagePicker imagePicker = ImagePicker();

  _UploadImageInitial({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: () async {
          final PickedFile pickedFile =
              await imagePicker.getImage(source: ImageSource.gallery);

          if (pickedFile != null) {
            ImageBloc.of(context).add(ImageUploadEvent(
              token: user.accessToken,
              field: pickedFile.path,
              file: File(pickedFile.path),
            ));
          }
        },
        child: Text("Upload"),
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
