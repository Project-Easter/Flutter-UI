import 'dart:convert';

import 'package:books_app/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'databaseService.dart';
import 'package:books_app/Constants/api.dart';
import 'package:books_app/Constants/exception.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin facebookLogin = FacebookLogin();

  //*Turn MyAppUser from FirebaseUser
  //Add this per Needed
  MyAppUser _retrieveUserFromFirebaseUser(User user) {
    return user != null ? MyAppUser(uid: user.uid) : null;
  }

//
  //Get current user Logged in Status.
  // User from Firebase to detect Auth changes-Listen in main
  dynamic get currentUserFromFireBase {
    return _auth.currentUser;
  }

  dynamic get getUID {
    return _auth.currentUser.uid;
  }

  //SignIn Anonymously
  Future<MyAppUser> signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;

      ///HELPER
      ///Convert user From Firebase to UserData Object
      UserData userData = makeUserDataFromAuthUser(user);

      ///This holds default values for new users
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
        //TODO: Redirects user to the homepage

      } else {
        var responseBody = jsonDecode(response.body);
        var errorId = responseBody['error']['id'];

        switch (errorId) {
          case Exception.INVALID_INPUT:
            {
              print('Invalid input');

              //TODO: Displays error message: Invalid email or password. Check your input and try once again.
              //! Too low or too many characters inside password / email

              break;
            }

          case Exception.INVALID_ACCOUNT_TYPE:
            {
              print('Account type is invalid');

              //TODO: Displays error message: You've already created an account using Google or Facebook

              break;
            }

          case Exception.INVALID_CREDENTIALS:
            {
              print('Invalid Credentials');

              //TODO: Displays error message: Invalid Credentials. Check your input and try again

              break;
            }

          case Exception.UNCONFIRMED_ACCOUNT:
            {
              print('Unconfirmed account');

              //TODO: Displays error message: Your account is not confirmed yet. Click here to confirm it.

              break;
            }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      var response = await http.post(Uri.parse(API_ROUTE + "/auth/new-account"),
          body: {"email": email, "password": password});

      if (response.statusCode == 201) {
        print('Registered successfully');
        //TODO: Redirects user to the ENTER YOUR CONFIRMATION CODE

      } else {
        var responseBody = jsonDecode(response.body);
        var errorId = responseBody['error']['id'];

        switch (errorId) {
          case Exception.INVALID_INPUT:
            {
              print('Invalid input');

              //TODO: Displays error message: Invalid email or password. Check your input and try once again.

              break;
            }

          case Exception.DUPLICATE_EMAIL:
            {
              print('Email already exists');

              //TODO: Displays error message: Email already exists. Please try a different one.

              break;
            }
        }
      }
    } catch (e) {
      print(e.toString());
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
