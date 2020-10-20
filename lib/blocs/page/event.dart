import 'package:flutter/foundation.dart';

abstract class PageEvent {
  const PageEvent();
}

class PageGoToEvent extends PageEvent {
  final int index;

  const PageGoToEvent({
    @required this.index,
  });
}
