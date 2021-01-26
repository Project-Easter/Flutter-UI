import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/routes.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:books_app/Screens/initial_screen.dart';

import 'package:books_app/Services/auth.dart';

class ConfirmScreen extends StatefulWidget {
  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _confirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white10,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => InitialScreen()));
            },
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.0, bottom: 20),
              child: Text(
                "Enter OTP",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 36),
              ),
            ),
            buildLayouts(),
            privacyPolicyLinkAndTermsOfService()
          ],
        ),
      ),
    );
  }

  Widget buildLayouts() {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: AspectRatio(
              aspectRatio: 343 / 52,
              child: Container(
                child: TextFormField(
                  key: ValueKey('confirm'),
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'Enter your confirmation code',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onSaved: (value) {
                    setState(() {
                      a.smsOTP = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: AspectRatio(
            aspectRatio: 343 / 52,
            child: Container(
              child: RaisedButton(
                color: blackButton,
                child: new Text(
                  'Continue',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                onPressed: () {
                  a.codeSent
                      ? a.signInWithOTP(a.smsOTP, a.verificationId)
                      : a.verifyPhone(a.phoneNo);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget privacyPolicyLinkAndTermsOfService() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Center(
          child: Text.rich(TextSpan(
              text: 'By signing up, you agree to Books App ',
              style: TextStyle(fontSize: 13, color: Colors.black),
              children: <TextSpan>[
            TextSpan(
                text: 'Terms of Service',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    // code to open / launch terms of service link here
                  }),
            TextSpan(
                text: ' and ',
                style: TextStyle(fontSize: 13, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // code to open / launch privacy policy link here
                        })
                ])
          ]))),
    );
  }
}
