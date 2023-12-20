import 'dart:typed_data';
import 'package:flutter_test_scheduler/blogic/requests/globalUrl.dart';
import 'package:http/http.dart' as http;

class FileUploadRequester {
  Future<void> uploadFile(Uint8List fileBytes, String fileName) async {
    final response = await http.post(
      Uri.parse('http://${globalUrl}api/excel/upload?fileName=$fileName'),
      body: fileBytes,
      headers: {'Content-Type': 'application/octet-stream'},
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      print('File uploaded successfully');
    } else {
      print('Failed to upload file. Status code: ${response.statusCode}');
    }
  }
}
