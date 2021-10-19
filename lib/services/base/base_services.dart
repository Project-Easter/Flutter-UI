import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseServices {
  Future<Map<String, dynamic>?> getAPI(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return jsonDecode(response.body) as Map<String, dynamic>?;
  }
}