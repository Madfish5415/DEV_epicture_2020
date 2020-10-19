import 'package:flutter/widgets.dart';

class PageModel {
  final WidgetBuilder builder;
  final PageItemModel item;

  PageModel({
    @required this.builder,
    this.item,
  });
}

class PageItemModel {
  final IconData iconData;
  final String label;

  PageItemModel({
    @required this.iconData,
    @required this.label,
  });
}
