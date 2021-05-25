import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/src/response.dart';

import '../Constants/exceptions.dart';
import '../Models/user.dart';
import '../Utils/Api.dart';
import '../Utils/helpers.dart';
import 'database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin facebookLogin = FacebookLogin();

  dynamic get currentUserFromFireBase {
    return _auth.currentUser;
  }

  dynamic get getUID {
    return _auth.currentUser.uid;
  }

  Future<String> confirmEmail(String email, String code) async {
    final Response response = await Api.confirmEmail(email, code);

    if (response.statusCode == 204) return null;

    final dynamic body = getBodyFromResponse(response);
    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Exception.INVALID_CONFIRMATION_CODE:
        {
          return 'Provided confirmation code is invalid.';
        }
      case Exception.EXPIRED_CONFIRMATION_CODE:
        {
          return 'Provided confirmation code has been expired. Click here to get a new one.';
        }
      default:
        {
          return 'An unknown error occured. Please try again later';
        }
    }
  }

  Future<void> facebookSignout() async {
    await _auth.signOut().then((onValue) {
      facebookLogin.logOut();
    });
  }

  Future<String> forgotPassword(String email) async {
    final Response response = await Api.forgotPassword(email);
    if (response.statusCode == 204) return null;

    final dynamic body = getBodyFromResponse(response);
    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Exception.EMAIL_NOT_FOUND:
        {
          return 'Provided email does not exist';
        }
      case Exception.INVALID_ACCOUNT_TYPE:
        {
          return 'Provided email is associated with the account created using Google or Facebook';
        }
      case Exception.UNCONFIRMED_ACCOUNT:
        {
          return 'Your account is not confirmed yet.';
        }
      default:
        {
          return 'An unknown error occured. Please try again later';
        }
    }
  }

  Future<void> googleSignout() async {
    GoogleSignIn().disconnect();
    await _auth.signOut();
    print('User Signed Out');
  }

  Future<String> login(String email, String password) async {
    final Response response = await Api.login(email, password);

    if (response.statusCode == 200) return null;

    final dynamic body = getBodyFromResponse(response);
    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Exception.INVALID_ACCOUNT_TYPE:
        {
          return 'You have created an account using Google or Facebook. Log in with one of them instead.';
        }
      case Exception.INVALID_CREDENTIALS:
        {
          return 'Invalid Credentials. Check your input and try again.';
        }
      case Exception.UNCONFIRMED_ACCOUNT:
        {
          return 'Your account is not confirmed yet. Click here to confirm it';
        }
      default:
        {
          return 'An unknown error occured. Please try again later';
        }
    }
  }

  UserData makeUserDataFromAuthUser(User user) {
    //IMP:DO NOT REMOVE THIS URL,this is the default image while signing up.
    //Change Image as per needed.A valid URL must be provided
    const String photoUrl =
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80';
    final UserData userData = UserData(
        //Storing Data For further requirement
        uid: user.uid,
        displayName: user.displayName ?? 'Your name',
        email: user.email ?? 'your@email.com',
        //this is not required.Just for test purpose
        emailVerified: user.emailVerified,
        phoneNumber: user.phoneNumber ?? 'Phone',
        photoURL: user.photoURL ?? photoUrl,
        city: 'Your city',
        state: 'State');
    return userData;
  }

  Future<String> register(String email, String password) async {
    final Response response = await Api.register(email, password);

    if (response.statusCode == 201) return null;

    final dynamic body = getBodyFromResponse(response);
    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Exception.DUPLICATE_EMAIL:
        {
          return 'Email already exists.';
        }
      default:
        {
          return 'An unknown error occured. Please try again later';
        }
    }
  }

  Future<String> resetPassword(
      String email, String password, String code) async {
    final Response response = await Api.resetPassword(email, password, code);
    if (response.statusCode == 204) return null;

    final dynamic body = getBodyFromResponse(response);
    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Exception.INVALID_CONFIRMATION_CODE:
        {
          return 'Provided confirmation code is invalid';
        }
      case Exception.EXPIRED_CONFIRMATION_CODE:
        {
          return 'Provided confirmation code has been expired. Click here to get a new one.';
        }
      default:
        {
          return 'An unknown error occured. Please try again later';
        }
    }
  }

  Future<String> signInWithFacebook() async {
    final FacebookLoginResult result = await facebookLogin.logIn();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken.token);

    final UserCredential fbAuthResult =
        await _auth.signInWithCredential(facebookAuthCredential);
    final User fbUser = fbAuthResult.user;

    if (fbUser != null) {
      assert(!fbUser.isAnonymous);
      assert(await fbUser.getIdToken() != null);
      final User currentUser = _auth.currentUser;
      assert(fbUser.uid == currentUser.uid);

      print('Facebook SignIn succeeded: $fbUser');

      return '$fbUser';
    }
    return null;
  }

  Future<MyAppUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);

    final User user = authResult.user;
    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      String token = await user.getIdToken(true);
      while (token.isNotEmpty) {
        final int initLength = token.length >= 500 ? 500 : token.length;
        print(token.substring(0, initLength));
        final int endLength = token.length;
        token = token.substring(initLength, endLength);
      }

      final UserData userData = makeUserDataFromAuthUser(user);

      await DatabaseService(uid: user.uid).updateUserData(userData);
      return _retrieveUserFromFirebaseUser(currentUser);
    }
    return null;
  }

  Future<void> signOutNormal() async {
    try {
      await _auth.signOut();
    } catch (e) {
      e.toString();
    }
  }

  MyAppUser _retrieveUserFromFirebaseUser(User user) {
    return user != null ? MyAppUser(uid: user.uid) : null;
  }
}
