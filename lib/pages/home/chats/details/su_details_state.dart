import 'dart:typed_data';

import 'package:palette_generator/palette_generator.dart';

class SUDetailsState {
  Uint8List? imageBytes;
  PaletteGenerator? paletteGenerator;
  final String imageUrl =
      'https://qiniu.aimissu.top/temporary/image39.jpg'; // Replace with your image URL

  SUDetailsState() {
    imageBytes = Uint8List(0); // 初始值为一个空的 Uint8List
    paletteGenerator = null; // 初始值为 null
  }
}
