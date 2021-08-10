import 'package:books_app/Utils/helpers.dart';
import 'package:books_app/constants/api.dart';
import 'package:http/http.dart';

class AuthRequests {
  static Future<Response> loginWithSocialMedia(String idToken) async {
    return sendRequest(() => post(Uri.parse(BASE_ROUTE + '/auth/social'),
        body: {'idToken': idToken}));
  }

  static Future<Response> logout(String email, String password) {
    return sendRequest(() => post(Uri.parse(BASE_ROUTE + '/auth/logout'),
        body: {'email': email, 'password': password}));
  }

  static Future<Response> register(String email, String password) {
    return sendRequest(() => post(Uri.parse(BASE_ROUTE + '/auth/new-account'),
        body: {'email': email, 'password': password}));
  }

  static Future<Response> login(String email, String password) {
    return sendRequest(() => post(Uri.parse(BASE_ROUTE + '/auth/email'),
        body: {'email': email, 'password': password}));
  }
}
