// lib/services/image_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static Future<Map<String, dynamic>> uploadImage(XFile pickedFile) async {
    final bytes = await pickedFile.readAsBytes();

    final uri = Uri.parse('https://api-ai--e-wzq.fly.dev/predict');

    final request = http.MultipartRequest('POST', uri)
      ..files.add(
        http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: pickedFile.name,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);

      return {
        'bytes': bytes,
        'result': data.isEmpty
            ? [
                {'class_name': 'Unknown', 'confidence': 0.0}
              ]
            : data,
      };
    } else {
      throw Exception("Upload failed with status: ${response.statusCode}");
    }
  }
}
