import '../interfaces/IRequester.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Requester implements IRequester{

  String baseUrl = "http://localhost:8080/ScheduleWebApp-1.0-SNAPSHOT/api/get-all-info";
  String baseUrlAndroid = "http://10.0.2.2:8080/ScheduleWebApp-1.0-SNAPSHOT/api/get-all-info";
  @override
  Future<dynamic> requestObjects(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrlAndroid/$endpoint'));



    if (response.statusCode == 200) {
      // Parse the response data and return it as a list of objects
      // Modify this part based on the actual response format from your API
      final parsed = json.decode(utf8.decode(response.body.runes.toList()));

      return parsed;
    } else {
      // Handle error cases here, for example:
      throw Exception('Failed to load objects');
    }
  }

  Requester();
  Requester.defineBaseUrl(this.baseUrl);

}