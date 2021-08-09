import 'package:books_app/Utils/helpers.dart';
import 'package:books_app/constants/api.dart';
import 'package:http/http.dart';

class UserRequests{

  static Future<Response> getUserData(String token) async {
    return sendRequest(() => get(Uri.parse(BASE_ROUTE + '/user/data'),
        headers: {'authorization': token}));
  }
  static Future<Response> location(String token) async {
    return sendRequest(() => patch(Uri.parse(BASE_ROUTE + '/user/location'),
        headers: {'authorization': token}));
  }
   static Future<Response> resetPassword(
      String email, String password, String code) async {
    return sendRequest(() => patch(Uri.parse(BASE_ROUTE + '/user/password'),
        body: {'email': email, 'password': password, 'code': code}));
  }
   static Future<Response> confirmEmail(String email, String code) async {
    return sendRequest(() => post(Uri.parse(BASE_ROUTE + '/user/email'),
        body: {'email': email, 'code': code}));
  }
}