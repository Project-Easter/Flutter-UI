import 'package:books_app/Utils/backend/user_data_requests.dart';
import 'package:books_app/Utils/keys_storage.dart';
import 'package:books_app/utils/helpers.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

// class MyAppUser {
//   String uid;

//   MyAppUser({this.uid});
// }

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
  String countryName;
  Map<String, dynamic> preferences;
  UserData(
      {this.uid,
      this.countryName,
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

class UserModel extends ChangeNotifier {
  String _id;
  String _email;
  String _firstName;
  String _lastName;
  String _joinedAt;
  String _avatar;
  bool _isAuthenticated;

  String get avatar => _avatar;
  String get email => _email;
  String get firstName => _firstName;
  String get id => _id;
  bool get isAuthenticated => _isAuthenticated;
  String get joinedAt => _joinedAt;
  String get lastName => _lastName;

  Future<void> fetchUserData() async {
    
    final Response response = await UserRequests.getUserData(TokenStorage.authToken);
    final dynamic body = await getBodyFromResponse(response);
    print('$body is the body of fetch user data inside user.dart file 123445');

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
