import 'package:books_app/constants/colors.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  static String fbauthtoken = '';
  static String googleAuthToken = '';
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin facebookLogin = FacebookLogin();

  dynamic get currentUserFromFireBase {
    return firebaseAuth.currentUser;
  }

  String get getUID {
    return firebaseAuth.currentUser!.uid;
  }

  Future<void> facebookSignout() async {
    await firebaseAuth.signOut().then((void onValue) {
      facebookLogin.logOut();
    });
  }

  Future<void> googleSignout() async {
    GoogleSignIn().disconnect();
    await firebaseAuth.signOut();
  }

  UserData makeUserDataFromAuthUser(User user) {
    const String photoUrl = 'assets/images/Explr Logo.png';
    final UserData userData = UserData(
      uid: user.uid,
      displayName: user.displayName ?? 'Your name',
      email: user.email ?? 'your@email.com',
      emailVerified: user.emailVerified,
      phoneNumber: user.phoneNumber ?? 'Phone',
      photoURL: user.photoURL ?? photoUrl,
      city: null,
      state: null,
      countryName: null,
    );
    return userData;
  }

  Future<User> signInWithFacebook() async {
    final FacebookLoginResult attempt = await facebookLogin.logIn();
    final OAuthCredential credential =
        FacebookAuthProvider.credential(attempt.accessToken!.token);
    final UserCredential result =
        await firebaseAuth.signInWithCredential(credential);

    final User? user = result.user;

    //Was not letting me return user... so I commented out this if statement.
    //if (user == null) return;

    final String idToken = await user!.getIdToken(true);
    print('ID token received from user.getIdToken(true) is $idToken');

    // try {
    //   fbauthtoken = await BackendService().loginWithSocialMedia(idToken);
    //   print('facebook token is $fbauthtoken');
    // } catch (error) {
    //   print(error.toString());
    // }
    return user;
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? attempt = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication authentication =
        await attempt!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );

    final UserCredential result =
        await firebaseAuth.signInWithCredential(credential);
    final User? user = result.user;

    if (user != null) {
      assert(!user.isAnonymous);
      print('The user here is $user');

      final User? currentUser = firebaseAuth.currentUser;
      assert(user.uid == currentUser!.uid);
      final String googleIdtoken = await firebaseAuth.currentUser!.getIdToken();

      // try {
      //   print('entered try catch');
      //   googleAuthToken =
      //       await BackendService().loginWithSocialMedia(googleIdtoken);

      //   print(
      //       'Google auth token from loginWithSocialMedia is $googleAuthToken');

      //   TokenStorage().storeAuthToken(googleAuthToken);
      //   //Add a timer for token expiration time

      //   TokenStorage().loadAuthToken();
      // } catch (e) {
      //   print('Damn we got an error: ' + e.toString());
      // }

      final UserData userData = makeUserDataFromAuthUser(user);
      await DatabaseService(uid: user.uid).updateUserData(userData);
      return user;
    }
  }

  Future<UserCredential?> signUpWithEmail(
      BuildContext context, String email, String pass) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: blackButton,
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: blackButton,
            content: Text('The account already exists for that email.')));
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
