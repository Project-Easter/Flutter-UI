import 'package:books_app/Constants/api.dart';
import 'package:http/http.dart';

class Api {
  static Future<Response> register(String email, String password) async {
    var response;

    try {
      response = await post(Uri.parse(API_ROUTE + "/auth/new-account"), body: {"email": email, "password": password});
    } catch (error) {
      print(error.toString());
    }

    return response;
  }

  static Future<Response> signInWithEmailAndPassword(String email, String password) async {
    var response;

    try {
      response = await post(Uri.parse(API_ROUTE + "/auth/email"), body: {"email": email, "password": password});
    } catch (error) {
      print(error.toString());
    }

    return response;
  }
}
