import 'package:books_app/Models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'databaseService.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FacebookLogin facebookLogin = FacebookLogin();

  //*Turn MyAppUSer from FirebaseUser
  //Add this per Needed
  MyAppUser _userFromFirebaseUser(User user) {
    return user != null ? MyAppUser(uid: user.uid) : null;
  }

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
      print(user);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // Create a new credential
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
      //Test Area
      var name, email, photoUrl, uid, emailVerified;
      name = user.displayName;
      email = user.email;
      photoUrl = user.photoURL;
      emailVerified = user.emailVerified;
      uid =
          user.uid; // The user's ID, unique to the Firebase project. Do NOT use
      // this value to authenticate with your backend server, if
      // you have one. Use User.getToken() instead.
      // print("Sign-in provider: " + providerId);
      print("  Provider-specific UID: " + uid);
      print("  Name: " + name);
      print("  Email: " + email);
      print("  Photo URL: " + photoUrl);
      print("Email Verified" + emailVerified);
      //Test Area
      print(currentUser);
      print('Google SignIn succeeded: $user');
      // return currentUser;
      return '$user';
    }
    return null;
  }

  Future<void> googleSignout() async {
    GoogleSignIn().disconnect();
    await _auth.signOut();
    print("User Signed Out");
  }

  Future<String> signInWithFacebook() async {
    // Trigger the sign-in flow
    final FacebookLoginResult result = await facebookLogin.logIn();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken.token);

    // Once signed in, return the UserCredential
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

  //Normal Signout
  Future<void> signOutNormal() async {
    try {
      await _auth.signOut();
    } catch (e) {
      e.toString();
    }
  }

//sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      //Convert user From Firebase to UserData Object
      UserData userData = UserData(
          //Storing Data For further requirement
          uid: user.uid,
          displayName: user.displayName ?? "Your name",
          email: user.email ?? "your@email.com",
          //this is not required.Just for test purpose
          emailVerified: user.emailVerified,
          phoneNumber: user.phoneNumber ?? "Phone",
          photoURL: user.photoURL ?? "Your photo",
          city: "Your city",
          state: "State");
      await DatabaseService(uid: user.uid).updateUserData(userData);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
