import 'package:books_app/Constants/Colors.dart';
import 'package:books_app/Constants/routes.dart';
import 'package:books_app/Widgets/button.dart';
import 'package:books_app/screens/Auth/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmEmailScreen extends StatefulWidget {
  @override
  _ConfirmEmailScreenState createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends State<ConfirmEmailScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _confirmemail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white10,
        leading: FlatButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Icon(Icons.arrow_back_rounded)),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 20),
              child: Text(
                'Confirm Email',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 36),
              ),
            ),
            buildLayouts(),
            button(context, blackButton, 'Continue', userName),
            SizedBox(
              height: 20.0,
            ),
            privacyPolicyLinkAndTermsOfService()
          ],
        ),
      ),
    );
  }

  Widget buildLayouts() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: AspectRatio(
          aspectRatio: 343 / 52,
          child: TextFormField(
            key: ValueKey('confirmemail'),
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            enableSuggestions: false,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter with your confirmation code';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: 'Enter Confirmation code',
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
              _confirmemail.text = value;
            },
          ),
        ),
      ),
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
