import 'package:books_app/Utils/helpers.dart';
import 'package:books_app/constants/api.dart';
import 'package:http/http.dart';

class MailRequest {
  static Future<Response> confirmationCode(String email) async {
    return sendRequest(() => post(
        Uri.parse(BASE_ROUTE + '/mail/email-confirmation'),
        body: {'email': email}));
  }

  static Future<Response> forgotPassword(String email) async {
    return sendRequest(() => post(
        Uri.parse(BASE_ROUTE + '/mail/password-reset'),
        body: {'email': email}));
  }
}
