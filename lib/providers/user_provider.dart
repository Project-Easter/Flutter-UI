import 'package:flutter/material.dart';
import 'package:books_app/utils/api.dart';
import 'package:books_app/utils/helpers.dart';

class UserProvider extends ChangeNotifier {
  String _id;
  String _email;
  String _firstName;
  String _lastName;
  String _joinedAt;
  String _avatar;
  bool _isAuthenticated = false;

  String get id => _id;
  String get email => _email;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get joinedAt => _joinedAt;
  String get avatar => _avatar;
  bool get isAuthenticated => _isAuthenticated;

  Future fetchUserData(String token) async {
    var response = await Api.getUserData(token);
    var body = getBodyFromResponse(response);

    if (body['id'] == null) {
      this._isAuthenticated = false;
      return;
    }

    this._id = body['id'];
    this._email = body['email'];
    this._firstName = body['firstName'];
    this._lastName = body['lastName'];
    this._joinedAt = body['joinedAt'];
    this._avatar = body['avatar'];
    this._isAuthenticated = true;

    notifyListeners();
  }
}
