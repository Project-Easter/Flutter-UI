import 'package:books_app/Services/database_service.dart';
import 'package:books_app/constants/error.dart';
import 'package:books_app/models/user.dart';
import 'package:books_app/utils/api.dart';
import 'package:books_app/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/src/response.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin facebookLogin = FacebookLogin();

  dynamic get currentUserFromFireBase {
    return firebaseAuth.currentUser;
  }

  dynamic get getUID {
    return firebaseAuth.currentUser.uid;
  }

  Future confirmEmail(String email, String code) async {
    final Response response = await Api.confirmEmail(email, code);

    if (response.statusCode == 204) return;

    final dynamic body = getBodyFromResponse(response);
    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Error.INVALID_CONFIRMATION_CODE:
        {
          throw Exception('Provided confirmation code is invalid.');
        }
      case Error.EXPIRED_CONFIRMATION_CODE:
        {
          throw Exception(
              'Provided confirmation code has been expired. Click here to get a new one.');
        }
      default:
        {
          throw Exception('An unknown error occured. Please try again later');
        }
    }
  }

//   Future<MyAppUser> signInWithGoogle() async {
//     final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//     final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     final UserCredential authResult = await firebaseAuth.signInWithCredential(credential);

//     final User user = authResult.user;
//     if (user != null) {
//       assert(!user.isAnonymous);
//       assert(await user.getIdToken() != null);
//       final User currentUser = firebaseAuth.currentUser;
//       assert(user.uid == currentUser.uid);

//       UserData userData = makeUserDataFromAuthUser(user);

//       await DatabaseService(uid: user.uid).updateUserData(userData);
//       return _retrieveUserFromFirebaseUser(currentUser);
//     }
//     return null;
//   }

//   Future<String> signInWithFacebook() async {
//     final FacebookLoginResult result = await facebookLogin.logIn();

//     final FacebookAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken.token);

//     final UserCredential fbAuthResult = await firebaseAuth.signInWithCredential(facebookAuthCredential);
//     final User fbUser = fbAuthResult.user;

//     if (fbUser != null) {
//       assert(!fbUser.isAnonymous);
//       assert(await fbUser.getIdToken() != null);
//       final User currentUser = firebaseAuth.currentUser;
//       assert(fbUsaer.uid == currentUser.uid);

//       print('Facebook SignIn succeeded: $fbUser');

//       return '$fbUser';
//     }
//     return null;
//   }

  Future<void> facebookSignout() async {
    await firebaseAuth.signOut().then((void onValue) {
      facebookLogin.logOut();
    });
  }

  Future forgotPassword(String email) async {
    final Response response = await Api.forgotPassword(email);
    if (response.statusCode == 204) return;

    final dynamic body = getBodyFromResponse(response);
    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Error.EMAIL_NOT_FOUND:
        {
          throw Exception('Provided email does not exist');
        }
      case Error.INVALID_ACCOUNT_TYPE:
        {
          throw Exception(
              'Provided email is associated with the account created using Google or Facebook');
        }
      case Error.UNCONFIRMED_ACCOUNT:
        {
          throw Exception('Your account is not confirmed yet.');
        }
      default:
        {
          throw Exception('An unknown error occured. Please try again later');
        }
    }
  }

  Future<void> googleSignout() async {
    GoogleSignIn().disconnect();
    await firebaseAuth.signOut();
  }

  Future<String> login(String email, String password) async {
    final response = await Api.login(email, password);
    final dynamic body = getBodyFromResponse(response);

    if (response.statusCode == 200) return body['token'] as String;

    final dynamic errorId = body['error']['id'];

    switch (errorId as int) {
      case Error.INVALID_ACCOUNT_TYPE:
        {
          throw Exception(
              'You have created an account using Google or Facebook. Log in with one of them instead.');
        }
      case Error.INVALID_CREDENTIALS:
        {
          throw Exception(
              'Invalid Credentials. Check your input and try again.');
        }
      case Error.UNCONFIRMED_ACCOUNT:
        {
          throw Exception(
              'Your account is not confirmed yet. Click here to confirm it');
        }
      default:
        {
          throw Exception('An unknown error occured. Please try again later');
        }
    }
  }

  Future<String> loginWithSocialMedia(String idToken) async {
    final Response response = await Api.loginWithSocialMedia(idToken);
    final dynamic body = getBodyFromResponse(response);

    if (response.statusCode == 200) return body['token'].toString();

    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Error.INVALID_ACCOUNT_TYPE:
        {
          throw Exception(
              'Provided email is associated with a regular account. Log in with email and password instead.');
        }
      default:
        {
          throw Exception('An unknown error occured. Please try again later');
        }
    }
  }

  UserData makeUserDataFromAuthUser(User user) {
    const String photoUrl =
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80';
    final UserData userData = UserData(
        uid: user.uid,
        displayName: user.displayName ?? 'Your name',
        email: user.email ?? 'your@email.com',
        emailVerified: user.emailVerified,
        phoneNumber: user.phoneNumber ?? 'Phone',
        photoURL: user.photoURL ?? photoUrl,
        city: 'Your city',
        state: 'State');
    return userData;
  }

  Future<void> register(String email, String password) async {
    final Response response = await Api.register(email, password);

    if (response.statusCode == 201) return;

    final dynamic body = getBodyFromResponse(response);
    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Error.DUPLICATE_EMAIL:
        {
          throw Exception('Email already exists.');
        }
      default:
        {
          throw Exception('An unknown error occured. Please try again later');
        }
    }
  }

  Future resetPassword(String email, String password, String code) async {
    final Response response = await Api.resetPassword(email, password, code);
    if (response.statusCode == 204) return;

    final dynamic body = getBodyFromResponse(response);
    final int errorId = body['error']['id'] as int;

    switch (errorId) {
      case Error.INVALID_CONFIRMATION_CODE:
        {
          throw Exception('Provided confirmation code is invalid');
        }
      case Error.EXPIRED_CONFIRMATION_CODE:
        {
          throw Exception(
              'Provided confirmation code has been expired. Click here to get a new one.');
        }
      default:
        {
          throw Exception('An unknown error occured. Please try again later');
        }
    }
  }

  Future signInWithFacebook() async {
    final FacebookLoginResult attempt = await facebookLogin.logIn();
    final OAuthCredential credential =
        FacebookAuthProvider.credential(attempt.accessToken.token);
    final UserCredential result =
        await firebaseAuth.signInWithCredential(credential);

    final User user = result.user;

    if (user == null) return null;

    final String idToken = await user.getIdToken(true);

    try {
      final String token = await loginWithSocialMedia(idToken);
      print(token);
    } catch (error) {
      print(error.toString());
    }
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount attempt = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication authentication =
        await attempt.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );

    final UserCredential result =
        await firebaseAuth.signInWithCredential(credential);
    final User user = result.user;

    if (user != null) {
      assert(!user.isAnonymous);
      print('The user here is $user');

      final User currentUser = firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);

      UserData userData = makeUserDataFromAuthUser(user);

      await DatabaseService(uid: user.uid).updateUserData(userData);
      return _retrieveUserFromFirebaseUser(currentUserFromFireBase as User);
    }

    final String idToken = await user.getIdToken(true);

    print(user);
    print('Current user of Firebase is below:');
    print(currentUserFromFireBase);
    // _retrieveUserFromFirebaseUser(user);
    try {
      final String token = await loginWithSocialMedia(idToken);
      print('The token here is $token');
      return user;
      // return _retrieveUserFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
    }
  }

  MyAppUser _retrieveUserFromFirebaseUser(User user) {
    return user != null ? MyAppUser(uid: user.uid) : null;
  }
}
