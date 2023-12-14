import 'dart:typed_data';
import 'package:http/http.dart' as http;

class FileUploadRequester {
  Future<void> uploadFile(Uint8List fileBytes, String fileName) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/ScheduleWebApp-1.0-SNAPSHOT/api/excel/upload?fileName=$fileName'),
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
