import 'package:books_app/Services/database_service.dart';
import 'package:books_app/Utils/backend/auth_requests.dart';
import 'package:books_app/Utils/backend/mail_request.dart';
import 'package:books_app/Utils/backend/quote_request.dart';
import 'package:books_app/Utils/backend/user_data_requests.dart';
import 'package:books_app/constants/error.dart';
import 'package:books_app/providers/user.dart';
import 'package:books_app/screens/dashboard/quotes.dart';
import 'package:books_app/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/src/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static String fbauthtoken = '';
  static String googleAuthToken = '';
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin facebookLogin = FacebookLogin();

  dynamic get currentUserFromFireBase {
    return firebaseAuth.currentUser;
  }

  String get getUID {
    return firebaseAuth.currentUser.uid;
  }

  Future confirmEmail(String email, String code) async {
    final Response response = await UserRequests.confirmEmail(email, code);

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

  Future<void> facebookSignout() async {
    await firebaseAuth.signOut().then((void onValue) {
      facebookLogin.logOut();
    });
  }

  Future forgotPassword(String email) async {
    final Response response = await MailRequest.forgotPassword(email);
    if (response.statusCode == 204) return;

    final dynamic body = await getBodyFromResponse(response);
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

  Future getQuote(String token) async {
    final Response response = await QuoteRequest.getQuoteData(token);
    try {
      // final Response response = await get(Uri.parse(BASE_ROUTE + '/quote'),
      //     headers: {'authorization': token});
      // final dynamic result = jsonDecode(response.body);
      final dynamic result = getBodyFromResponse(response);
      print('Quote result is $result');
      if (result.statusCode == 200) {
        print('Result is $result');

        print(result.text.toString());
        print(result.authorization.toString());
        return Quote(
            result['text'].toString(), result['authorization'].toString());
      }

      // if (result != null) return result['token'] as String;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> googleSignout() async {
    GoogleSignIn().disconnect();
    await firebaseAuth.signOut();
  }

  Future<String> login(String email, String password) async {
    final Response response = await AuthRequests.login(email, password);
    final dynamic body = getBodyFromResponse(response);
    print(body + 'is the body');

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
    final Response response = await AuthRequests.loginWithSocialMedia(idToken);
    final dynamic body = await getBodyFromResponse(response);

    print('Piotr login wale ka Body is $body');
    if (response.statusCode == 200) {
      String t = body['token'] as String;
      print('Piotr login wale ka 200 respone  is $t');
      return body['token'] as String;
    }

    final int errorId = body['error']['id'] as int;
    print('The error ID of loginWithSocialMedia made bu Piotr is $errorId');

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

  Future register(String email, String password) async {
    final Response response = await AuthRequests.register(email, password);

    if (response.statusCode == 201) return;

    final dynamic body = await getBodyFromResponse(response);
    print(body.toString() + ' is the response body');
    if (body['error']['id'] != null) {
      final dynamic errorId = body['error']['id'];

      switch (errorId as int) {
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
  }

  Future resetPassword(String email, String password, String code) async {
    final Response response =
        await UserRequests.resetPassword(email, password, code);
    if (response.statusCode == 204) return;

    final dynamic body = await getBodyFromResponse(response);
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
    print('ID token received from user.getIdToken(true) is $idToken');

    try {
      fbauthtoken = await loginWithSocialMedia(idToken);
      print('facebook token is $fbauthtoken');
    } catch (error) {
      print(error.toString());
    }
    return user;
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
      final String tokens = await firebaseAuth.currentUser.getIdToken();

      try {
        print('entered try catch');
        // print(
        //     '$authentication.idToken will be the token that will be passed to loginWithSocialMedia');
        print(
            '$tokens will be the token that will be passed to loginWithSocialMedia');
        googleAuthToken = await loginWithSocialMedia(tokens);
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        // preferences.setString('googleIdToken', authentication.idToken);
        preferences.setString('token', tokens);
        print('Google Auth token is $googleAuthToken');
        // final String idtoken = await user.getIdToken(true);
        final String idtoken = authentication.idToken;

        print('The IDtoken is $idtoken');
      } catch (e) {
        print('Damn we got an error: ' + e.toString());
      }

      final UserData userData = makeUserDataFromAuthUser(user);
      await DatabaseService(uid: user.uid).updateUserData(userData);
      return user;
    }
  }
}
