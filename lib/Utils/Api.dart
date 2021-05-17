import 'package:http/http.dart';

class Api {
  static const String BASE_ROUTE = "https://explr-api.herokuapp.com/api/v1";

  static Future<Response> register(String email, String password) async {
    var response;

    try {
      response = await post(Uri.parse(BASE_ROUTE + "/auth/new-account"), body: {"email": email, "password": password});
    } catch (error) {
      print(error.toString());
    }

    return response;
  }

  static Future<Response> login(String email, String password) async {
    var response;

    try {
      response = await post(Uri.parse(BASE_ROUTE + "/auth/email"), body: {"email": email, "password": password});
    } catch (error) {
      print(error.toString());
    }

    return response;
  }

  static Future<Response> forgotPassword(String email) async {
    var response;

    try {
      response = await post(Uri.parse(BASE_ROUTE + "/mail/password-reset"), body: {"email": email});
    } catch (error) {
      print(error.toString());
    }

    return response;
  }

  static Future<Response> resetPassword(String email, String password, String code) async {
    var response;

    try {
      response = await patch(Uri.parse(BASE_ROUTE + "/user/password"), body: {"email": email, "password": password, "code": code});
    } catch (error) {
      print(error.toString());
    }

    return response;
  }

  static Future<Response> confirmEmail(String email, String code) async {
    var response;

    try {
      response = await post(Uri.parse(BASE_ROUTE + "/user/email"), body: {"email": email, "code": code});
    } catch (error) {
      print(error.toString());
    }

    return response;
  }
}
