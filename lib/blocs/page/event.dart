import 'package:epicture/blocs/common/event.dart';
import 'package:flutter/foundation.dart';

abstract class PageEvent extends Event {
  const PageEvent();
}

class PageGoToEvent extends PageEvent {
  final int index;

  const PageGoToEvent({
    @required this.index,
  });
}
