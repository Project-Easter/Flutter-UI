import 'dart:async';
import 'package:http/http.dart';

class Api {
  static const String BASE_ROUTE = "https://explr-api.herokuapp.com/api/v1";

  static Future<Response> sendRequest(Future<Response> Function() request) async {
    var response;

    try {
      response = await request();
    } catch (error) {
      print(error.toString());
    }

    return response;
  }

  static Future<Response> register(String email, String password) {
    return sendRequest(() => post(Uri.parse(BASE_ROUTE + "/auth/new-account"), body: {"email": email, "password": password}));
  }

  static Future<Response> login(String email, String password) async {
    return sendRequest(() => post(Uri.parse(BASE_ROUTE + "/auth/email"), body: {"email": email, "password": password}));
  }

  static Future<Response> forgotPassword(String email) async {
    return sendRequest(() => post(Uri.parse(BASE_ROUTE + "/mail/password-reset"), body: {"email": email}));
  }

  static Future<Response> resetPassword(String email, String password, String code) async {
    return sendRequest(() => patch(Uri.parse(BASE_ROUTE + "/user/password"), body: {"email": email, "password": password, "code": code}));
  }

  static Future<Response> confirmEmail(String email, String code) async {
    return sendRequest(() => post(Uri.parse(BASE_ROUTE + "/user/email"), body: {"email": email, "code": code}));
  }
}
