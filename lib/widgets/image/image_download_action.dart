import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class ImageDownloadActionWidget extends StatelessWidget {
  final String url;

  ImageDownloadActionWidget({
    @required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.download_sharp),
      onPressed: () async {
        try {
          final Directory downloadsDir = await getExternalStorageDirectory();

          await FlutterDownloader.enqueue(
              url: url, savedDir: downloadsDir.path);

          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Download: Started.")));
        } catch (e) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Download: Error.")));
        }
      },
    );
  }
}
