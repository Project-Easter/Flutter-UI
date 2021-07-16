import 'dart:convert';

import 'package:http/http.dart';

Future<dynamic> getBodyFromResponse(Response response) async {
  return await jsonDecode(response.body);
}

bool notNull(Object object) {
  return object != null;
}
