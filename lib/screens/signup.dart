import 'package:books_app/screens/confirm.dart';
import 'package:books_app/screens/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white10,
        leading: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            },
            child: Image.asset(
              "images/icon.PNG",
            )),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Username",
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
            key: ValueKey('username'),
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            enableSuggestions: false,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your Username';
              }
              return null;
            },
            decoration: InputDecoration(
                hintText: 'Username',
                focusedBorder:
                    Theme.of(context).inputDecorationTheme.focusedBorder,
                enabledBorder:
                    Theme.of(context).inputDecorationTheme.enabledBorder),
            onSaved: (value) {
              _userName.text = value;
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
      child: MaterialButton(
        color: Theme.of(context).buttonColor,
        child: new Text(
          'Sign Up',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ConfirmScreen()));
        },
        shape: Theme.of(context).buttonTheme.shape,
      ),
    );
  }

  Widget privacyPolicyLinkAndTermsOfService() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text.rich(
          TextSpan(
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
            ],
          ),
        ),
      ),
    );
  }
}
