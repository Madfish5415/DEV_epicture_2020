import 'package:epicture/blocs/common/event.dart';

class PickerEvent extends Event {
  const PickerEvent();
}

class PickerGetCameraEvent extends PickerEvent {
  const PickerGetCameraEvent();
}

class PickerGetGalleryEvent extends PickerEvent {
  const PickerGetGalleryEvent();
}
