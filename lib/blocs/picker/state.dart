import 'dart:io';

import 'package:epicture/blocs/picker.dart';
import 'package:flutter/foundation.dart';

class PickerState {
  const PickerState();
}

class PickerInitialState extends PickerState {
  const PickerInitialState();
}

class PickerLoadingState extends PickerState {
  const PickerLoadingState();
}

class PickerGotState extends PickerState {
  final File file;

  const PickerGotState({@required this.file});
}

class PickerErrorState extends PickerState {
  final PickerEvent event;
  final String message;

  const PickerErrorState({@required this.event, this.message});
}
