import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../../../su_export_comment.dart';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../discover/su_discover_model.dart';

class SUDetailsLogic extends GetxController {
  late Uint8List imageBytes;
  late PaletteGenerator paletteGenerator;
  late Size imageSize;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<String> getImageColor(String color, String imageUrl) async {
    if (color != '') {
      return color;
    }
    await _loadImageBytes(imageUrl);
    await _updatePalette();
    return _getPreferredColorHex();
  }

  Future<void> _loadImageBytes(String imageUrl) async {
    imageBytes = (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
        .buffer
        .asUint8List();
    final image = await loadImage(Uint8List.fromList(imageBytes!));
    imageSize = Size(image.width.toDouble(), image.height.toDouble());
  }

  Future<void> _updatePalette() async {
    final imageProvider = MemoryImage(imageBytes);
    paletteGenerator = await PaletteGenerator.fromImageProvider(
      imageProvider,
      size: imageSize, // Size of the image to analyze
      region: Rect.fromCenter(
        center: Offset(imageSize.width / 2, imageSize.height / 2),
        width: imageSize.width / 3,
        height: imageSize.height / 3,
      ), // Region to analyze
    );
    // print('---------------------------imageSize : $imageSize');
  }

  Future<ui.Image> loadImage(Uint8List list) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(list, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  String _getPreferredColorHex() {
    print(
        '------------------dominantColor : ${paletteGenerator.dominantColor?.color.value.toRadixString(16).substring(2)}');
    // print(
    //     '------------------lightVibrantColor : ${paletteGenerator.lightVibrantColor?.color.value.toRadixString(16).substring(2)}');
    // print(
    //     '------------------vibrantColor : ${paletteGenerator.vibrantColor?.color.value.toRadixString(16).substring(2)}');
    // print(
    //     '------------------darkVibrantColor : ${paletteGenerator.darkVibrantColor?.color.value.toRadixString(16).substring(2)}');
    // print(
    //     '------------------lightMutedColor : ${paletteGenerator.lightMutedColor?.color.value.toRadixString(16).substring(2)}');
    // print(
    //     '------------------mutedColor : ${paletteGenerator.mutedColor?.color.value.toRadixString(16).substring(2)}');
    // print(
    //     '------------------darkMutedColor : ${paletteGenerator.darkMutedColor?.color.value.toRadixString(16).substring(2)}');

    if (paletteGenerator.darkMutedColor != null &&
        paletteGenerator.darkMutedColor!.color != Colors.transparent) {
      return '#${paletteGenerator.darkMutedColor!.color.value.toRadixString(16).substring(2)}';
    } else {
      return '#${paletteGenerator.dominantColor!.color.value.toRadixString(16).substring(2)}';
    }
  }
}
