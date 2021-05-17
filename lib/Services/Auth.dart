import 'package:books_app/util/Api.dart';
import 'package:books_app/util/helpers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:books_app/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'databaseService.dart';
import 'package:books_app/Constants/api.dart';
import 'package:books_app/Constants/exception.dart';

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
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
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

    final FacebookAuthCredential facebookAuthCredential =
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

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var response = await http.post(Uri.parse(API_ROUTE + "/auth/email"),
          body: {"email": email, "password": password});

      if (response.statusCode == 200) {
        print('Logged in successfully');
      } else {
        var responseBody = jsonDecode(response.body);
        var errorId = responseBody['error']['id'];

        switch (errorId) {
          case Exception.INVALID_ACCOUNT_TYPE:
            {
              return AlertDialog(
                  content: Text(
                      'You have already created an account using Google or Facebook'));
            }

          case Exception.INVALID_CREDENTIALS:
            {
              print('Invalid Credentials');
              return AlertDialog(
                  content: Text(
                      'Invalid Credentials. Check your input and try again'));
            }

          case Exception.UNCONFIRMED_ACCOUNT:
            {
              return AlertDialog(
                  content: Text(
                      'Your account is not confirmed yet. Click here to confirm it'));
            }
          default:
            {
              return AlertDialog(
                  content: Text('Unknown error occurred. Try again later.'));
            }
        }
      }
    } catch (e) {
      print(e.toString());
    }
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
}
