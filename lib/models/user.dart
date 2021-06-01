import 'package:books_app/utils/api.dart';
import 'package:books_app/utils/helpers.dart';
import 'package:flutter/widgets.dart';

class UserModel extends ChangeNotifier {
  String _id;
  String _email;
  String _firstName;
  String _lastName;
  String _joinedAt;
  String _avatar;
  bool _isAuthenticated;

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

class MyAppUser {
  String uid;
  MyAppUser({this.uid});
}

class UserData {
  String uid;
  String displayName;
  String email;
  bool emailVerified;
  String refreshToken;
  bool isAnonymous;
  String phoneNumber;
  String photoURL;
  String city;
  String state;
  double latitude;
  double longitude;
  double locationRange;
  Map<String, dynamic> preferences;
  UserData(
      {this.uid,
      this.displayName,
      this.email,
      this.emailVerified,
      this.isAnonymous,
      this.phoneNumber,
      this.photoURL,
      this.city,
      this.state,
      this.refreshToken,
      this.latitude = 0.0,
      this.longitude = 0.0,
      this.preferences,
      this.locationRange});
}
