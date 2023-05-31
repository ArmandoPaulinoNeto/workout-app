import 'dart:convert';
import 'dart:typed_data';

class ConvertBase64 {
  convertToBase64(Uint8List bytes) {
    return base64Encode(bytes);
  }
}
