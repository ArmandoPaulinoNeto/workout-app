import 'dart:convert';
import 'dart:io';

class ConvertBase64 {
  convertToBase64(String path) {
    final bytes = File(path).readAsBytesSync();
    return base64Encode(bytes);
  }

  convertBase64ToImage(String base64) {
    return base64Decode(base64);
  }
}
