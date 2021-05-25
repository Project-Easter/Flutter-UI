import 'dart:convert';
import 'package:http/http.dart';

dynamic getBodyFromResponse(Response response) {
  return jsonDecode(response.body);
}
