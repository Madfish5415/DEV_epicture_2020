import 'package:epicture/widgets/utility/elevation.dart';
import 'package:flutter/material.dart';

class InkWellWidget extends StatelessWidget {
  final GestureTapCallback onTap;

  InkWellWidget({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevationWidget(
      child: InkWell(
        splashColor: Theme.of(context).accentColor.withAlpha(128),
        onTap: onTap,
      ),
    );
  }
}
