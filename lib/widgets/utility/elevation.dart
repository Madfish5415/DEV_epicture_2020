import 'package:flutter/material.dart';

class ElevationWidget extends StatelessWidget {
  final Widget child;
  final double elevation;

  ElevationWidget({
    @required this.child,
    this.elevation = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        elevation: elevation,
        child: child,
      ),
    );
  }
}
