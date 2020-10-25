import 'dart:io';

import 'package:epicture/blocs/picker/event.dart';
import 'package:epicture/blocs/picker/state.dart';
import 'package:epicture/repositories/picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickerBloc extends Bloc<PickerEvent, PickerState> {
  final PickerRepository _repository;

  static PickerBloc of(BuildContext context) {
    return BlocProvider.of(context);
  }

  PickerBloc(this._repository) : super(PickerInitialState());

  @override
  Stream<PickerState> mapEventToState(PickerEvent event) async* {
    yield PickerLoadingState();

    if (event is PickerGetCameraEvent) {
      yield* _getCamera(event);
    } else if (event is PickerGetGalleryEvent) {
      yield* _getGallery(event);
    }
  }

  Stream<PickerState> _getCamera(PickerGetCameraEvent event) async* {
    try {
      final File file = await _repository.getCameraImage();

      yield PickerGotState(file: file);
    } on Exception catch (e) {
      yield PickerErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }

  Stream<PickerState> _getGallery(PickerGetGalleryEvent event) async* {
    try {
      final File file = await _repository.getGalleryImage();

      yield PickerGotState(file: file);
    } on Exception catch (e) {
      yield PickerErrorState(
        event: event,
        message: e.toString(),
      );
    }
  }
}
