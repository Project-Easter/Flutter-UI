import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/colors.dart';
import '../Constants/routes.dart';
import '../Services/auth.dart';
import '../States/auth_state.dart';
import '../States/email_state.dart';
import '../States/password_state.dart';
import '../Utils/Helpers/not_null.dart';
import '../Utils/size_config.dart';
import '../Widgets/Auth/auth_button.dart';
import '../Widgets/text_field.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends AuthState<InitialScreen>
    with EmailState<InitialScreen>, PasswordState<InitialScreen> {
  //Init AuthService

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //Alert dialogue to show error and response
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      child: Container(
        // color: Color.fromRGBO(40, 175, 176, 1),
        color: Color.fromRGBO(88, 188, 130, 1),
        child: Center(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, right: 15.0),
                    child: _skipButton(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  'assets/Explr Logo.png',
                  scale: 1.4,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Explr',
                  style: GoogleFonts.muli(
                      color: blackButton,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                  key: this.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EmailTextField(onChanged: this.updateEmail),
                      PasswordTextField(onChanged: this.updatePassword)
                    ],
                  ),
                ),
                buildForgotPasswordButton(),
                AuthButton(
                  text: 'Sign in',
                  formKey: this.formKey,
                  onClick: this.onSubmit,
                  onSuccess: this.onSuccess,
                  onError: this.onError,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 1,
                      width: 120,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      ' or you can ',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(height: 1, width: 120, color: Colors.black),
                  ],
                ),
                SizedBox(height: 20),
                _signUpwithEmail(),
                SizedBox(height: 10),
                _socialMediaHandles(),
                SizedBox(height: 40),
              ].where(notNull).toList(),
            ),
          ),
        ),
      ),
    ));
  }

  Widget buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text("Forgot password?",
            textAlign: TextAlign.center,
            style: GoogleFonts.muli(
              color: Color.fromRGBO(224, 39, 20, 1),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            )),
        onPressed: () {
          Navigator.pushNamed(this.context, Routes.FORGOT_PASSWORD);
        },
      ),
    );
  }

  Future<String> onSubmit() async {
    return await AuthService()
        .login(_emailController.text, _passwordController.text);
  }

  void onSuccess() {
    print('Logged in successfully');
  }

  void showErrorDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    // show the dialog
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _signUpwithEmail() {
    return SizedBox(
      height: 44,
      width: 250,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          // primary: Color(0xFF246BFD),
          primary: blackButton,
        ),
        onPressed: () async {
          Navigator.popAndPushNamed(context, Routes.REGISTER);
        },
        icon: Icon(
          Icons.mail_outline_outlined,
          color: Colors.white,
        ),
        label: Text(
          'Sign up with email',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _skipButton() {
    return ElevatedButton(
      onPressed: () {
        print('Skip button pressed');
      },
      style: ElevatedButton.styleFrom(
        primary: blackButton,
        onPrimary: Colors.white12,
        minimumSize: Size(55, 24.75),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      child: Text(
        'Skip',
        style: GoogleFonts.poppins(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _socialMediaHandles() {
    return SizedBox(
      height: 44,
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 44,
            width: 110,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                side: BorderSide(color: Colors.black87),
              ),
              onPressed: () async {
                try {
                  dynamic res = await AuthService().signInWithGoogle();
                  print(res);
                  if (res != null) {
                    print(res);
                    Navigator.pushNamed(context, Routes.HOME);
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Icon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            height: 44,
            width: 110,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                side: BorderSide(color: Colors.black87),
              ),
              onPressed: () async {
                AuthService().signInWithFacebook().whenComplete(() {
                  Navigator.pushNamed(context, Routes.HOME);
                });
              },
              child: Icon(
                FontAwesomeIcons.facebook,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
