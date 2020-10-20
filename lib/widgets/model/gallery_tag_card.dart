import 'package:epicture/models/gallery_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GalleryTagCard extends StatelessWidget {
  final GalleryTagModel _tag;

  GalleryTagCard(this._tag);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[
        Expanded(
          child: Text(_tag.name, textAlign: TextAlign.center),
        ),
        Expanded(
          child:
              Text('Followers ${_tag.followers}', textAlign: TextAlign.center),
        ),
      ]),
    );
  }
}
