import 'package:books_app/Utils/Api.dart';
import 'package:books_app/Utils/helpers.dart';
import 'package:books_app/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'databaseService.dart';
import 'package:books_app/Constants/Exception.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin facebookLogin = FacebookLogin();

  MyAppUser _retrieveUserFromFirebaseUser(User user) {
    return user != null ? MyAppUser(uid: user.uid) : null;
  }

  dynamic get currentUserFromFireBase {
    return _auth.currentUser;
  }

  dynamic get getUID {
    return _auth.currentUser.uid;
  }

  Future<MyAppUser> signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;

      UserData userData = makeUserDataFromAuthUser(user);

      await DatabaseService(uid: user.uid).updateUserData(userData);
      print(user);
      return _retrieveUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<MyAppUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential authResult = await _auth.signInWithCredential(credential);

    final User user = authResult.user;
    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      String token = await user.getIdToken(true);
      while (token.length > 0) {
        int initLength = (token.length >= 500 ? 500 : token.length);
        print(token.substring(0, initLength));
        int endLength = token.length;
        token = token.substring(initLength, endLength);
      }

      UserData userData = makeUserDataFromAuthUser(user);

      await DatabaseService(uid: user.uid).updateUserData(userData);
      return _retrieveUserFromFirebaseUser(currentUser);
    }
    return null;
  }

  Future<void> googleSignout() async {
    GoogleSignIn().disconnect();
    await _auth.signOut();
    print("User Signed Out");
  }

  Future<String> signInWithFacebook() async {
    final FacebookLoginResult result = await facebookLogin.logIn();

    final FacebookAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken.token);

    final UserCredential fbAuthResult = await _auth.signInWithCredential(facebookAuthCredential);
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

  Future<void> facebookSignout() async {
    await _auth.signOut().then((onValue) {
      facebookLogin.logOut();
    });
  }

  Future<void> signOutNormal() async {
    try {
      await _auth.signOut();
    } catch (e) {
      e.toString();
    }
  }

  UserData makeUserDataFromAuthUser(User user) {
    //IMP:DO NOT REMOVE THIS URL,this is the default image while signing up.
    //Change Image as per needed.A valid URL must be provided
    String photoUrl =
        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80";
    UserData userData = UserData(
        //Storing Data For further requirement
        uid: user.uid,
        displayName: user.displayName ?? "Your name",
        email: user.email ?? "your@email.com",
        //this is not required.Just for test purpose
        emailVerified: user.emailVerified,
        phoneNumber: user.phoneNumber ?? "Phone",
        photoURL: user.photoURL ?? photoUrl,
        city: "Your city",
        state: "State");
    return userData;
  }

  Future<String> register(String email, String password) async {
    var response = await Api.register(email, password);

    if (response.statusCode == 201) return null;

    var body = getBodyFromResponse(response);
    var errorId = body['error']['id'];

    switch (errorId) {
      case Exception.DUPLICATE_EMAIL:
        {
          return 'Duplicate email';
        }
      default:
        {
          return 'An unknown error occured. Please try again later';
        }
    }
  }

  Future<String> signInWithEmailAndPassword(String email, String password) async {
    var response = await Api.signInWithEmailAndPassword(email, password);

    if (response.statusCode == 200) return null;

    var body = getBodyFromResponse(response);
    var errorId = body['error']['id'];

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

  Future<String> forgotPassword(String email) async {
    var response = await Api.forgotPassword(email);
    if (response.statusCode == 204) return null;

    var body = getBodyFromResponse(response);
    var errorId = body['error']['id'];

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

  Future<String> resetPassword(String email, String password, String code) async {
    var response = await Api.resetPassword(email, password, code);
    if (response.statusCode == 204) return null;

    var body = getBodyFromResponse(response);
    var errorId = body['error']['id'];

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

  Future<String> confirmEmail(String email, String code) async {
    var response = await Api.confirmEmail(email, code);

    if (response.statusCode == 204) return null;

    var body = getBodyFromResponse(response);
    var errorId = body['error']['id'];

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
}
