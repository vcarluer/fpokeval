import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class ImageUtils {
  static Future<String> fileToBase64(String path) async {
    final bytes = await File(path).readAsBytes();
    return base64Encode(bytes);
  }

  static Future<String> webFileToBase64(Uint8List bytes) async {
    return base64Encode(bytes);
  }
}