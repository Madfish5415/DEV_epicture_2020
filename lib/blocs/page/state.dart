import 'package:epicture/models/page.dart';
import 'package:flutter/foundation.dart';

class PageState {
  const PageState();
}

class PageInitialState extends PageState {
  const PageInitialState();
}

class PageGoneToState extends PageState {
  final PageModel page;

  const PageGoneToState({@required this.page});
}
