import 'package:books_app/Constants/api.dart';
import 'package:http/http.dart';

class Api {
  static Future<Response> register(String email, String password) async {
    Response response;

    try {
      response = await post(Uri.parse(API_ROUTE + '/auth/new-account'),
          body: {'email': email, 'password': password});
    } catch (error) {
      print(error.toString());
    }

    return response;
  }

  static Future<Response> login(String email, String password) async {
    Response response;

    try {
      response = await post(Uri.parse(API_ROUTE + '/auth/email'),
          body: {'email': email, 'password': password});
    } catch (error) {
      print(error.toString());
    }

    return response;
  }

  static Future<Response> forgotPassword(String email) async {
    Response response;

    try {
      response = await post(Uri.parse(API_ROUTE + '/mail/password-reset'),
          body: {'email': email});
    } catch (error) {
      print(error.toString());
    }

    return response;
  }

  static Future<Response> resetPassword(
      String email, String password, String code) async {
    Response response;

    try {
      response = await patch(Uri.parse(API_ROUTE + '/user/password'),
          body: {'email': email, 'password': password, 'code': code});
    } catch (error) {
      print(error.toString());
    }

    return response;
  }

  static Future<Response> confirmEmail(String email, String code) async {
    Response response;

    try {
      response = await post(Uri.parse(API_ROUTE + '/user/email'),
          body: {'email': email, 'code': code});
    } catch (error) {
      print(error.toString());
    }

    return response;
  }
}
