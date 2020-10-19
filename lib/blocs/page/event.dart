import 'package:flutter/foundation.dart';

abstract class PageEvent {
  const PageEvent();
}

class PageToEvent extends PageEvent {
  final int index;

  const PageToEvent({
    @required this.index,
  });
}
