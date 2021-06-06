import 'package:books_app/utils/api.dart';
import 'package:books_app/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserProvider extends ChangeNotifier {
  String _id;
  String _email;
  String _firstName;
  String _lastName;
  String _joinedAt;
  String _avatar;
  bool _isAuthenticated = false;

  String get avatar => _avatar;
  String get email => _email;
  String get firstName => _firstName;
  String get id => _id;
  bool get isAuthenticated => _isAuthenticated;
  String get joinedAt => _joinedAt;
  String get lastName => _lastName;

  Future<dynamic> fetchUserData(String token) async {
    final Response response = await Api.getUserData(token);
    final dynamic body = getBodyFromResponse(response);

    if (body['id'] == null) {
      _isAuthenticated = false;
      return;
    }

    _id = body['id'] as String;
    _email = body['email'] as String;
    _firstName = body['firstName'] as String;
    _lastName = body['lastName'] as String;
    _joinedAt = body['joinedAt'] as String;
    _avatar = body['avatar'] as String;
    _isAuthenticated = true;

    notifyListeners();
  }
}
