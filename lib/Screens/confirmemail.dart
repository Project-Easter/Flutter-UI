import 'package:books_app/Screens/login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white10,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Image.asset(
            "images/icon.PNG",
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Confirm your Email",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            buildLayouts(),
            SizedBox(
              height: 20.0,
            ),
            signUpButton(),
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
      child: Column(
        children: [
          TextFormField(
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
            decoration: InputDecoration(
                hintText: 'Enter your confirmation code',
                focusedBorder:
                    Theme.of(context).inputDecorationTheme.focusedBorder,
                enabledBorder:
                    Theme.of(context).inputDecorationTheme.enabledBorder),
            onSaved: (value) {
              _confirmemail.text = value;
            },
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }

  Widget signUpButton() {
    return Container(
      height: MediaQuery.of(context).size.height / 13.5,
      width: MediaQuery.of(context).size.width / 1.0,
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Theme.of(context).buttonColor,
          shape: Theme.of(context).buttonTheme.shape,
        ),
        child: new Text(
          'Continue',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginScreen()));
        },
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
