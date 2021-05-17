import 'package:http/http.dart';
import 'dart:convert';

dynamic getBodyFromResponse(Response response) {
  return jsonDecode(response.body);
}

bool notNull(Object object) {
  return object != null;
}
