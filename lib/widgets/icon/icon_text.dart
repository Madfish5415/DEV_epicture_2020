import 'package:flutter/material.dart';

class IconTextWidget extends StatelessWidget {
  final Icon icon;
  final Text text;
  final EdgeInsets iconPadding;

  IconTextWidget({
    @required this.icon,
    @required this.text,
    this.iconPadding = const EdgeInsets.only(right: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: iconPadding,
          child: icon,
        ),
        Flexible(
          child: text,
        ),
      ],
    );
  }
}
