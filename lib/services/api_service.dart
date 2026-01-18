import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:but_is_it_jain_app/models/scan_result.dart';

class ApiService {
  static const String _endpoint =
      'https://jain-product-identifier-api.onrender.com/classify';

  static Future<ScanResult> classifyImage(File imageFile) async {
    final uri = Uri.parse(_endpoint);

    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath(
        'file', // MUST be 'file' (matches your JS code)
        imageFile.path,
      ),
    );

    final response = await request.send();

    if (response.statusCode != 200) {
      final errorText = await response.stream.bytesToString();
      throw Exception('Server error: $errorText');
    }

    final responseBody = await response.stream.bytesToString();
    final jsonData = jsonDecode(responseBody);

    return ScanResult.fromJson(jsonData);
  }
}
