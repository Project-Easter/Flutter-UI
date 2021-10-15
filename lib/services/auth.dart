import 'package:books_app/constants/colors.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/services/database_service.dart';
import 'package:books_app/utils/keys_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService extends ChangeNotifier {
  static String fbauthtoken = '';
  static String googleAuthToken = '';
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TokenStorage _tokenStorage = TokenStorage();

  dynamic get currentUserFromFireBase {
    return firebaseAuth.currentUser;
  }

  String get getUID {
    return firebaseAuth.currentUser.uid;
  }

  Stream<User> get onAuthStateChanged {
    return firebaseAuth.authStateChanges();
  }

  Future<void> googleSignout() async {
    GoogleSignIn().disconnect();
    await firebaseAuth.signOut();
    await _tokenStorage.deleteSessionKey();
  }

  //for sign up using google
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

  //for sign up using email and password
  UserData makeUserDataForSignUp(User user, String username, String phone) {
    const String photoUrl = 'assets/images/Explr Logo.png';
    final UserData userData = UserData(
      uid: user.uid,
      displayName: username ?? 'Your name',
      email: user.email ?? 'your@email.com',
      emailVerified: user.emailVerified,
      phoneNumber: phone ?? 'Phone',
      photoURL: user.photoURL ?? photoUrl,
      isAnonymous: user.isAnonymous,
      city: null,
      state: null,
      countryName: null,
    );
    return userData;
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
      final String googleIdtoken = await firebaseAuth.currentUser.getIdToken();

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

  //for register
  Future<UserCredential> signUpWithEmail(BuildContext context, String username,
      String phone, String email, String pass) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      if (userCredential != null) {
        final UserData userData =
            makeUserDataForSignUp(userCredential.user, username, phone);
        await DatabaseService(uid: userCredential.user.uid)
            .updateUserData(userData);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: blackButton, content: Text('An error occured!.')));
      }
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

  // for login
  Future<void> signInWithEmail(
      BuildContext context, String email, String pass) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      // return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: blackButton,
            content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: blackButton,
            content: Text('Wrong password provided for that user.')));
      }
    }
  }
  Future<void>ResetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
  // sign out from app
  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await _tokenStorage.deleteSessionKey();
  }
}
