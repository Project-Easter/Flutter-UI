import 'package:books_app/constants/api.dart';
import 'package:books_app/utils/helpers.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class UserRequests {
  static Future<Response> getUserData(String token) async {
    return sendRequest(() => get(
          Uri.parse(BASE_ROUTE + '/user/data'),
          headers: <String, String>{'authorization': token},
        ));
  }

  static Future<Response> location(
      String token, num latitude, num longitude) async {
    return sendRequest(() => patch(
          Uri.parse(BASE_ROUTE + '/user/location'),
          headers: <String, String>{'authorization': token},
          body: <String, num>{
            'latitude': latitude,
            'longitude': longitude,
          },
        ));
  }

  static Future<Response> userAvatar(String token, String profilePic) async {
    return sendRequest(() => patch(
          Uri.parse(BASE_ROUTE + '/user/avatar'),
          headers: <String, String>{'authorization': token},
          body: {'file': profilePic},
        ));
  }

  static Future<Response> userIdentity(
      String token, String firstName, String lastName) async {
    return sendRequest(() => put(
          Uri.parse(BASE_ROUTE + '/user/identity'),
          headers: <String, String>{
            'authorization': token,
          },
          body: <String, String>{'firstName': firstName, 'lastName': lastName},
        ));
  }

  static Future<Response> userPreference(
      String token, String book, String author) async {
    return sendRequest(() => put(
          Uri.parse(BASE_ROUTE + '/user/preference'),
          headers: <String, String>{
            'authorization': token,
          },
          body: <String, String>{'book': book, 'author': 'author'},
        ));
  }

  static Future<Response> resetPassword(
      String email, String password, String code) async {
    return sendRequest(() => patch(Uri.parse(BASE_ROUTE + '/user/password'),
            body: <String, String>{
              'email': email,
              'password': password,
              'code': code
            }));
  }

  static Future<Response> confirmEmail(String email, String code) async {
    return sendRequest(() => post(Uri.parse(BASE_ROUTE + '/user/email'),
        body: {'email': email, 'code': code}));
  }
}
