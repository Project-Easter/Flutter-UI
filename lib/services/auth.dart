import 'package:books_app/utils/api.dart';
import 'package:books_app/utils/helpers.dart';
import 'package:books_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'database.dart';
import 'package:books_app/constants/error.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin facebookLogin = FacebookLogin();

  MyAppUser _retrieveUserFromFirebaseUser(User user) {
    return user != null ? MyAppUser(uid: user.uid) : null;
  }

  dynamic get currentUserFromFireBase {
    return firebaseAuth.currentUser;
  }

  dynamic get getUID {
    return firebaseAuth.currentUser.uid;
  }

  Future<MyAppUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential authResult = await firebaseAuth.signInWithCredential(credential);

    final User user = authResult.user;
    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final User currentUser = firebaseAuth.currentUser;
      assert(user.uid == currentUser.uid);

      UserData userData = makeUserDataFromAuthUser(user);

      await DatabaseService(uid: user.uid).updateUserData(userData);
      return _retrieveUserFromFirebaseUser(currentUser);
    }
    return null;
  }

  Future<void> googleSignout() async {
    GoogleSignIn().disconnect();
    await firebaseAuth.signOut();
  }

  Future<String> signInWithFacebook() async {
    final FacebookLoginResult result = await facebookLogin.logIn();

    final FacebookAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken.token);

    final UserCredential fbAuthResult = await firebaseAuth.signInWithCredential(facebookAuthCredential);
    final User fbUser = fbAuthResult.user;

    if (fbUser != null) {
      assert(!fbUser.isAnonymous);
      assert(await fbUser.getIdToken() != null);
      final User currentUser = firebaseAuth.currentUser;
      assert(fbUser.uid == currentUser.uid);

      print('Facebook SignIn succeeded: $fbUser');

      return '$fbUser';
    }
    return null;
  }

  Future<void> facebookSignout() async {
    await firebaseAuth.signOut().then((onValue) {
      facebookLogin.logOut();
    });
  }

  UserData makeUserDataFromAuthUser(User user) {
    String photoUrl =
        "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80";
    UserData userData = UserData(
        uid: user.uid,
        displayName: user.displayName ?? "Your name",
        email: user.email ?? "your@email.com",
        emailVerified: user.emailVerified,
        phoneNumber: user.phoneNumber ?? "Phone",
        photoURL: user.photoURL ?? photoUrl,
        city: "Your city",
        state: "State");
    return userData;
  }

  Future register(String email, String password) async {
    var response = await Api.register(email, password);

    if (response.statusCode == 201) return;

    var body = getBodyFromResponse(response);
    var errorId = body['error']['id'];

    switch (errorId) {
      case Error.DUPLICATE_EMAIL:
        {
          throw new Exception('Email already exists.');
        }
      default:
        {
          throw new Exception('An unknown error occured. Please try again later');
        }
    }
  }

Future loginWithGoogle() async {
    var attempt = await GoogleSignIn().signIn();
    var authentication = await attempt.authentication;

    var credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );

    var result = await firebaseAuth.signInWithCredential(credential);
    var user = result.user;

    if (user == null) return null;

    var idToken = await user.getIdToken(true);

    try {
      var token = loginWithSocialMedia(idToken);
      print(token);
    } catch (error) {
      print(error.toString());
    }
  }

  Future<String> loginWithSocialMedia(String idToken) async {
    var response = await Api.loginWithSocialMedia(idToken);

    if (response.statusCode == 200) return null;

    var body = getBodyFromResponse(response);
    var errorId = body['error']['id'];

    if (body.token != null) return body.token;

    switch (errorId) {
      case Error.INVALID_ACCOUNT_TYPE:
        {
          throw new Exception("Provided email is associated with a regular account. Log in with email and password instead.");
        }
      default:
        {
          throw new Exception('An unknown error occured. Please try again later');
        }
    }
  }

  Future<String> login(String email, String password) async {
    var response = await Api.login(email, password);

    if (response.statusCode == 200) return null;

    var body = getBodyFromResponse(response);
    var errorId = body['error']['id'];

    switch (errorId) {
      case Error.INVALID_ACCOUNT_TYPE:
        {
          throw new Exception('You have created an account using Google or Facebook. Log in with one of them instead.');
        }
      case Error.INVALID_CREDENTIALS:
        {
          throw new Exception('Invalid Credentials. Check your input and try again.');
        }
      case Error.UNCONFIRMED_ACCOUNT:
        {
          throw new Exception('Your account is not confirmed yet. Click here to confirm it');
        }
      default:
        {
          throw new Exception('An unknown error occured. Please try again later');
        }
    }
  }

  Future forgotPassword(String email) async {
    var response = await Api.forgotPassword(email);
    if (response.statusCode == 204) return;

    var body = getBodyFromResponse(response);
    var errorId = body['error']['id'];

    switch (errorId) {
      case Error.EMAIL_NOT_FOUND:
        {
          throw new Exception('Provided email does not exist');
        }
      case Error.INVALID_ACCOUNT_TYPE:
        {
          throw new Exception('Provided email is associated with the account created using Google or Facebook');
        }
      case Error.UNCONFIRMED_ACCOUNT:
        {
          throw new Exception('Your account is not confirmed yet.');
        }
      default:
        {
          throw new Exception('An unknown error occured. Please try again later');
        }
    }
  }

  Future resetPassword(String email, String password, String code) async {
    var response = await Api.resetPassword(email, password, code);
    if (response.statusCode == 204) return;

    var body = getBodyFromResponse(response);
    var errorId = body['error']['id'];

    switch (errorId) {
      case Error.INVALID_CONFIRMATION_CODE:
        {
          throw new Exception('Provided confirmation code is invalid');
        }
      case Error.EXPIRED_CONFIRMATION_CODE:
        {
          throw new Exception('Provided confirmation code has been expired. Click here to get a new one.');
        }
      default:
        {
          throw new Exception('An unknown error occured. Please try again later');
        }
    }
  }

  Future confirmEmail(String email, String code) async {
    var response = await Api.confirmEmail(email, code);

    if (response.statusCode == 204) return;

    var body = getBodyFromResponse(response);
    var errorId = body['error']['id'];

    switch (errorId) {
      case Error.INVALID_CONFIRMATION_CODE:
        {
          throw new Exception('Provided confirmation code is invalid.');
        }
      case Error.EXPIRED_CONFIRMATION_CODE:
        {
          throw new Exception('Provided confirmation code has been expired. Click here to get a new one.');
        }
      default:
        {
          throw new Exception('An unknown error occured. Please try again later');
        }
    }
  }
}
