import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

Future<PaletteGenerator> getImagePalette(ImageProvider imageProvider) async {
  final PaletteGenerator imagePalette = await PaletteGenerator
      .fromImageProvider(imageProvider);

  return imagePalette;
}

Future<Color> getImageDominantColor(ImageProvider imageProvider) async {
  final PaletteGenerator imagePalette = await getImagePalette(imageProvider);

  return imagePalette.dominantColor.color;
}
