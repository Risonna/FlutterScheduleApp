import 'package:flutter_test_scheduler/blogic/requests/globalUrl.dart';

import '../interfaces/IRequester.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Requester implements IRequester{

  @override
  Future<dynamic> requestObjects(String endpoint) async {
    final response = await http.get(Uri.parse('http://${globalUrl}api/get-all-info/$endpoint'));

    if (response.statusCode == 200) {
      final parsed = json.decode(utf8.decode(response.body.runes.toList()));
      return parsed;
    } else {
      throw Exception('Failed to load objects');
    }
  }

}