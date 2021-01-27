import 'package:books_app/Screens/Auth/register.dart';
import 'package:books_app/Screens/initial_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:books_app/Constants/routes.dart';

AuthService a;

class AuthService {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  bool codeSent = false;

  handleAuth() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return RegisterScreen();
          } else {
            return InitialScreen();
          }
        });
  }

  //OTP verification
  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      this.codeSent = true;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        timeout: const Duration(seconds: 20),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsOTPSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  //Sign out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //SignIn
  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsOTP, verId) {
    AuthCredential authCreds =
        PhoneAuthProvider.getCredential(verificationId: verId, smsCode: smsOTP);
    signIn(authCreds);
  }
}
