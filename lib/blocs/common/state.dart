import 'package:epicture/blocs/common/event.dart';
import 'package:flutter/foundation.dart';

class ErrorState {
  final Event event;
  final String message;

  ErrorState({
    @required this.event,
    this.message,
  });
}
